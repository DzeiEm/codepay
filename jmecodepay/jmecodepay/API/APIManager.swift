
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
//
//    func registerUser(_ user: User, completion: @escaping(Result<User, APIErrors>) -> Void) {
//
//        guard let url = APIEndpoints.registerUser.url  else {
//            completion(.failure(APIErrors.invalidURL))
//            return
//        }
//
//        let registerUserRequest = User()
//
//        guard let requestBodyJSON = try? encoder.encode(registerUserRequest) else {
//            completion(.failure(APIErrors.serializationError))
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = HTTPMethod.post
//        urlRequest.httpBody = requestBodyJSON
//
//        urlSession.dataTask(with: urlRequest,
//                            completionHandler: { data, _, error in
//
//            if let error = error {
//                completion(.failure(APIErrors.requestError(reason: error.localizedDescription)))
//            }
//            guard let data = data,
//                  let userResponse = try? decoder.decode(User.self, from: data)
//            else {
//                completion(.failure(.parsingError))
//                return
//            }
//            completion(.success(User())
//        }).resume()
//    }

//    func createAccount(_ account: AccountRequest, completion: @escaping(Result<AccountRequest, APIError>) -> Void) {
//
//        guard let url = APIEndpoint.createAccount.url  else {
//            completion(.failure(APIError.invalidURL))
//            return
//        }
//
//        let registerUserRequest = AccountRequest(phoneNumber: account.phoneNumber,
//                                                 currency: account.currency,
//                                                 balance: account.balance)
//
//        guard let requestBodyJSON = try? encoder.encode(registerUserRequest) else {
//            completion(.failure(APIError.serializationError))
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = HTTPMethod.post
//        urlRequest.httpBody = requestBodyJSON
//
//        urlSession.dataTask(with: urlRequest,
//                            completionHandler: { data, _, error in
//
//            if let error = error {
//                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
//            }
//            guard let data = data,
//                  let accountResponse = try? decoder.decode(AccountResponse.self, from: data)
//            else {
//                completion(.failure(.parsingError))
//                return
//            }
//            completion(.success(AccountRequest(phoneNumber: accountResponse.phoneNumber,
//                                               currency: accountResponse.currency,
//                                               balance: accountResponse.balance)))
//        }).resume()
//    }
}

//
//extension APIManager {
//
//    func getAllUserTransactions(completion: @escaping (Result<[Transaction], APIError>) -> Void) {
//
//        guard let url = APIEndpoint.getAllTransactions.url else {
//            completion(.failure(APIError.invalidURL))
//            return
//        }
//
//        urlSession.dataTask(with: url, completionHandler: { data, _, error in
//
//            if let error = error {
//                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
//                return
//            }
//            guard let data = data,
//                let transactions =  try? decoder.decode([TransactionsdResponse].self, from: data)
//
//                else {
//                    completion(.failure(APIError.parsingError))
//                    return
//                }
//                completion(.success(transactions.compactMap({ transaction in
//
////                    Transaction(senderNo: transaction.senderId,
////                                receiverNo: transaction.receiverId,
////                                transactionId: transaction.id,
////                                amount: transaction.amount,
////                                currency: transaction.currency,
////                                subject: transaction.reference)
//                })))
//            }).resume()
//    }
//
//    func getRecentUserTransactions(completion: @escaping (Result<[Transaction], APIError>) -> Void) {
//
//        guard let url = APIEndpoint.getAllTransactions.url else {
//            completion(.failure(APIError.invalidURL))
//            return
//        }
//
//        urlSession.dataTask(with: url, completionHandler: { data, _, error in
//
//            if let error = error {
//                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
//                return
//            }
//            guard let data = data,
//                let transactions =  try? decoder.decode([TransactionsdResponse].self, from: data)
//
//                else {
//                    completion(.failure(APIError.parsingError))
//                    return
//                }
//                completion(.success(transactions.compactMap({ transaction in
//
////                    Transaction(senderNo: transaction.senderId,
////                                receiverNo: transaction.receiverId,
////                                transactionId: transaction.id,
////                                amount: transaction.amount,
////                                currency: transaction.currency,
////                                subject: transaction.reference)
//                })))
//            }).resume()
//    }
//}
