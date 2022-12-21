
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

    func createUser(_ user: User, _ completion: @escaping(Result<User, APIErrors>) -> Void) {

        guard let url = APIEndpoints.user.url  else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        
        let registerUserRequest = User(phoneNumber: user.phoneNumber, password: user.password)
        
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
//            completion(.success(User(phoneNumber: user.phoneNumber, password: user.password)))
            completion(.success(userResponse))
        }).resume()
    }

    
    func createAccount(_ account: AccountRequest , _ completion: @escaping(Result<AccountRequest, APIErrors>) -> Void) {

        guard let url = APIEndpoints.account.url  else {
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
            completion(.success(User(phoneNumber: userResponse.phoneNumber, password: userResponse.password)))
    
        }).resume()
    }
    
    func getAllUsers(completion: @escaping(Result<[User], APIErrors>) -> Void) {
        
        guard let url = APIEndpoints.getAllUsers.url else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        
        urlSession.dataTask(with: url,
                            completionHandler: { data, _, error in

            if let error = error {
                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
            }
            guard let data = data,
                  let allusersResponse = try? decoder.decode([User].self, from: data)
            else {
                completion(.failure(.parsingError))
                return
            }
            
            completion(.success(allusersResponse.compactMap { user in
                
                User(phoneNumber: user.phoneNumber, password: user.password)
                
            }))
            print(allusersResponse)
    
        }).resume()
        
    }

}
