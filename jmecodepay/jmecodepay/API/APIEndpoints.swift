
import Foundation


enum APIEndpoints {
    
    case createUser
    case createAccount
    case getUser
    case getUserTransactions

    var url: URL? {
        switch self {
        case .createAccount:
            return makeURL(endpoint: "user")
        case .createUser:
            return makeURL(endpoint: "account")
        case .getUser:
            return makeURL(endpoint: "")
        case .getUserTransactions:
            return makeURL(endpoint: "")
        }
    }
}

private extension APIEndpoints {
    
    var BaseUrlString: String {
        "https://6368dedf15219b849608f700.mockapi.io/api/v3"
    }
    
    func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseUrlString + endpoint

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
