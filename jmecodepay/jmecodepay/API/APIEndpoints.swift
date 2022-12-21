
import Foundation


enum APIEndpoints {
    
    case user
    case account
    case transaction
    
    
    
    case getUser(phone: String)
    case getUserTransactions
    case getAllUsers

    var url: URL? {
        switch self {
            
        case .user:
            return makeURL(endpoint: "user")
        case .account:
            return makeURL(endpoint: "account")
        case .transaction:
            return makeURL(endpoint: "transaction")
            
        case .getUser(phone: let phone):
            return makeURL(endpoint: "user")
        case .getUserTransactions:
            return makeURL(endpoint: "user")
        case .getAllUsers:
            return makeURL(endpoint: "user")
        }
    }
}

private extension APIEndpoints {
    
    var BaseUrlString: String {
        "https://6368dedf15219b849608f700.mockapi.io/api/v3"
    }
    
    var phone: String {
        "phoneNumber"
    }
    
    func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseUrlString + endpoint

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
