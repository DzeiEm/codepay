
import Foundation

struct APIManager {
    
    private enum HTTPMethod {
        static let get = "GET"
        static let post = "POST"
        static let put = "PUT"
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
        
        let registerUserRequest = User(id: "", phoneNumber: phoneNumber, password: password)
        
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
    
    
//    func isUserExist(phoneNumber: String, _ completion: @escaping(Result<User, APIErrors>) -> Void) {
//        guard let url = APIEndpoints.isUserExist(phoneNumber: phoneNumber).url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        urlSession.dataTask(with: url, completionHandler: { data, _, error in
//            if let error = error {
//                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
//            }
//            guard let data = data,
//                  let userResponse = try? decoder.decode([User].self, from: data) else {
//                completion(.failure(.parsingError))
//                return
//            }
//            if let user = userResponse.first {
//                completion(.success(user))
//                return
//            } else {
//                completion(.failure(.userNotFound))
//            }
//            
//        }).resume()
//    }
//    
//    func getToken(user: User, _ completion: @escaping(Result<TokenResponse, APIErrors>) -> Void) {
//
//        guard let url = APIEndpoints.getUserToken(user: user).url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        urlSession.dataTask(with: url, completionHandler: { data, _, error in
//
//            if let error = error {
//                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
//            }
//
//            guard let data = data,
//                  let tokenResponse = try? decoder.decode(TokenResponse.self, from: data) else {
//                completion(.failure(.parsingError))
//                return
//            }
//
//            completion(.success(tokenResponse))
//        }).resume()
//    }
//
    
    func isAccountIsTaken(phoneNumber: String, _ completion: @escaping(Result<AccountResponse, APIErrors>) -> Void) {
        
        guard let url = APIEndpoints.isUserExist(phoneNumber: phoneNumber).url else {
            completion(.failure(.invalidURL))
            return
        }
        
        urlSession.dataTask(with: url) { data, _, error in
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
    
//    func updateUserAccount(account: AccountResponse, phoneNumber: String?, currency: String?, amount: Double?, _ completion: @escaping(Result<AccountResponse, APIErrors>) -> Void) {
//
//        guard let url = APIEndpoints.accountId(account: account).url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        var updateAccount = AccountResponse(id: account.id,
//                                            phoneNumber: account.phoneNumber,
//                                            currency: account.currency,
//                                            balance: account.balance)
//
//        if let currency = currency  {
//            updateAccount.currency = currency
//        }
//
//        if let amount = amount  {
//            updateAccount.balance += amount
//        }
//
//        if let phoneNumber = phoneNumber {
//            updateAccount.phoneNumber = phoneNumber
//        }
//
//        guard let transactionRequest = try? encoder.encode(updateAccount)  else {
//            completion(.failure(.serializationError))
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = HTTPMethod.put
//        urlRequest.httpBody = transactionRequest
//
//        urlSession.dataTask(with: urlRequest, completionHandler: { data, _, error in
//            if let error = error {
//                completion(.failure(.parsingError))
//            }
//
//            guard let data = data,
//                  let accountResponse = try? decoder.decode(AccountResponse.self, from: data) else {
//                completion(.failure(.parsingError))
//                return
//            }
//            completion(.success(accountResponse))
//        }).resume()
//    }
//
//    func getUserTransactions(phoneNumber: String, _ completion: @escaping(Result<[TransactionResponse], APIErrors>)  -> Void) {
//
//        guard let url = APIEndpoints.account.url  else {
//            completion(.failure(APIErrors.invalidURL))
//            return
//        }
//
//        urlSession.dataTask(with: url,
//                            completionHandler: { data, _, error in
//
//            if let error = error {
//                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
//            }
//
//            guard let data = data,
//                  let transactionResponse = try? decoder.decode([TransactionResponse].self, from: data)
//            else {
//                completion(.failure(.parsingError))
//                return
//            }
//            completion(.success(transactionResponse))
//        }).resume()
//
//    }
//
//    func sendMoney(sender: AccountResponse,
//                   receiver: AccountResponse,
//                   amount: Double?,
//                   currency: String,
//                   reference: String, _ completion: @escaping(Result<TransactionResponse, APIErrors>) -> Void) {
//
//        let createOn = Int(Date().timeIntervalSince1970)
//
//        guard let url = APIEndpoints.transaction.url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//
//        let transactionResponse = TransactionResponse(id: "",
//                                                      senderId: sender.phoneNumber,
//                                                      receiverId: receiver.phoneNumber,
//                                                      amount: amount,
//                                                      currency: currency,
//                                                      createdOn: createOn,
//                                                      reference: reference)
//
//        guard let transactionResponse = try? encoder.encode(transactionResponse) else {
//            completion(.failure(.serializationError))
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = HTTPMethod.post
//        urlRequest.httpBody = transactionResponse
//
//
//        urlSession.dataTask(with: urlRequest, completionHandler: { data, _, error in
//            if let error = error {
//                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
//            }
//
//            guard let data = data,
//                  let userResponse = try? decoder.decode(TransactionResponse.self, from: data) else {
//                completion(.failure(.parsingError))
//                return
//            }
//            completion(.success(userResponse))
//        }).resume()
//    }
}
