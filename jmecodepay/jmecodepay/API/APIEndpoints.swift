
import Foundation


enum APIEndpoints {
    
    case user
    case account
    case accountId(account: AccountResponse)
    case transaction
    case isUserExist(phoneNumber: String)
    case getUserToken(user: User)
    

    var url: URL? {
        switch self {
        case .user:
            return makeURL(endpoint: "user")
        case .account:
            return makeURL(endpoint: "account")
        case .accountId(account: let account):
            let accountId = account.id
            return makeURL(endpoint: "account\(accountId)")
        case .transaction:
            return makeURL(endpoint: "transaction")
        case .isUserExist(phoneNumber: let phoneNumber):
            let phoneQueryIteem = URLQueryItem(name: phone, value: phoneNumber)
            return makeURL(endpoint: "account", queryItems: [phoneQueryIteem])
        case .getUserToken(let user):
            let id = user.id
            return makeURL(endpoint: "user\(id)")
           
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
