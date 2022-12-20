
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

    func registerUser(_ user: User, completion: @escaping(Result<User, APIErrors>) -> Void) {

        guard let url = APIEndpoints.createUser.url  else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        
        let registerUserRequest = User(phone: user.phone, password: user.password)
        
        guard let requestBodyJSON = try? encoder.encode(user) else {
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
            completion(.success(User(phone: user.phone, password: user.password)))
        }).resume()
    }

    
    func createAccount(_ account: AccountRequest , completion: @escaping(Result<AccountRequest, APIErrors>) -> Void) {

        guard let url = APIEndpoints.createAccount.url  else {
            completion(.failure(APIErrors.invalidURL))
            return
        }

        let registerUserRequest = AccountRequest(phoneNumber: account.phoneNumber, currency: account.currency)

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
                  let accountResponse = try? decoder.decode(AccountResponse.self, from: data)
            else {
                completion(.failure(.parsingError))
                return
            }
            completion(.success(AccountRequest(phoneNumber: accountResponse.phoneNumber,
                                               currency: accountResponse.currency)
            ))
        }).resume()
    }
    
    
    func getUser(by phone: String?, completion: @escaping(Result<User, APIErrors>) -> Void) {
        
        guard let phone = phone else {
            return
        }
        
        guard let url = APIEndpoints.getUser(phone: phone).url else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        
        urlSession.dataTask(with: url,
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
            completion(.success(User(phone: userResponse.phone, password: userResponse.password)))
    
        }).resume()
    }
}
