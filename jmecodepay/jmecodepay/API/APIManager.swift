
import Foundation

struct APIManager {
    
    private enum HTTPMethod {
        static let get = "GET"
        static let post = "POST"
    }
    
    private enum HeaderKey {
        static let headerContent = "Content-Type"
    }
    
    private enum HeaderValue {
        static let content = "application/json"
    }
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private var urlSession: URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = [
            HeaderKey.headerContent: HeaderValue.content
        ]

        return URLSession(configuration: sessionConfiguration)
    }
}


extension APIManager {

    func createUser(phoneNumber: String, password: String, _ completion: @escaping(Result<User, APIErrors>) -> Void) {

        guard let url = APIEndpoints.user.url  else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        
        let registerUserRequest = User(phoneNumber: phoneNumber, password: password)
        
        guard let requestBodyJSON = try? encoder.encode(registerUserRequest) else {
            completion(.failure(APIErrors.serializationError))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post
        urlRequest.httpBody = requestBodyJSON

        urlSession.dataTask(with: urlRequest,
                            completionHandler: { data, _, error in

            if let error = error {
                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
            }
            guard let data = data,
                  let userResponse = try? decoder.decode(User.self, from: data)
            else {
                completion(.failure(.parsingError))
                return
            }
            completion(.success(userResponse))
        }).resume()
    }
    
    func isAccountIsTaken(phoneNumber: String, _ completion: @escaping(Result<AccountResponse, APIErrors>) -> Void) {
        
        guard let url = APIEndpoints.isUserExist(phoneNumber: phoneNumber).url else {
            completion(.failure(.invalidURL))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.serializationError))
                return
            }
            
            guard let userResponse = try? JSONDecoder().decode([AccountResponse].self, from: data) else {
                completion(.failure(.parsingError))
                return
            }
            if let user = userResponse.first {
                completion(.success(user))
                return
            } else {
                completion(.failure(.userNotFound))
                return
            }
        }.resume()
        
        
    }

    
    func createAccount(phoneNumber: String, currency: String, _ completion: @escaping(Result<AccountResponse, APIErrors>) -> Void) {

        guard let url = APIEndpoints.account.url  else {
            completion(.failure(APIErrors.invalidURL))
            return
        }

        let createAccount = AccountResponse(id: "", phoneNumber: phoneNumber, currency: currency, balance: 0.00)
        
        guard let requestBodyJSON = try? encoder.encode(createAccount) else {
            completion(.failure(APIErrors.serializationError))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post
        urlRequest.httpBody = requestBodyJSON

        urlSession.dataTask(with: urlRequest,
                            completionHandler: { data, _, error in

            if let error = error {
                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
            }
            
            guard let data = data,
                  let accountResponse = try? decoder.decode(AccountResponse.self, from: data)
            else {
                completion(.failure(.parsingError))
                return
            }
            completion(.success(accountResponse))
        }).resume()
    }
    
    
    
    func getUserTransactions(phoneNumber: String, _ completion: @escaping(Result<[TransactionResponse], APIErrors>)  -> Void) {
        
        
        guard let url = APIEndpoints.account.url  else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        
        urlSession.dataTask(with: url,
                            completionHandler: { data, _, error in

            if let error = error {
                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
            }
            
            guard let data = data,
                  let transactionResponse = try? decoder.decode([TransactionResponse].self, from: data)
            else {
                completion(.failure(.parsingError))
                return
            }
            completion(.success(transactionResponse))
        }).resume()
    
    }
    
}
