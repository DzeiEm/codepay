
import Foundation


enum APIEndpoints {
    
    case user
    case account
    case accountId(account: AccountResponse)
    case transaction
    case checkForUser(phoneNumber: String)
    case checkForAccount(phoneNumber: String)
    case getUserTransactions(phoneNumber: String)
    case getUserToken(user: User)
    

    var url: URL? {
        switch self {
        case .checkForUser(phoneNumber: let phoneNumber):
            let phoneQueryIteem = URLQueryItem(name: phone, value: phoneNumber)
            return makeURL(endpoint: "user", queryItems: [phoneQueryIteem])
        case .checkForAccount(phoneNumber: let phoneNumber):
            let queryItem = URLQueryItem(name: phone, value: phoneNumber)
            return makeURL(endpoint: "account", queryItems: [queryItem])
        case .accountId(let account):
            let accountId = account.id
            return makeURL(endpoint: "account\(accountId)")
        case .getUserTransactions(let phoneNumber):
            let queryItem = URLQueryItem(name: search, value: phoneNumber)
            return makeURL(endpoint: "transaction", queryItems: [queryItem])
            
            
            
            
            
        case .user:
            return makeURL(endpoint: "user")
        case .account:
            return makeURL(endpoint: "account")
        case .getUserToken(let user):
            let id = user.id
            return makeURL(endpoint: "user\(id)")
        case .transaction:
            return makeURL(endpoint: "transaction")
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
    
    var search: String {
        "search"
    }
    
    func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseUrlString + endpoint

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
