

import Foundation

class AccountManager {
    
    let apiManager =  APIManager()
    static var loggedInAccount: AccountResponse?
    
    
    enum AccountManagerError: Error {
        
        case accountAlreadyExists
        case wrongPassword
        case accountNotFound
        
        var error: String {
            switch self {
            case .accountAlreadyExists:
                return "Account already exists"
            case .wrongPassword:
                return "Wrong password"
            case .accountNotFound:
                return "Account not found"
            }
        }
    }
}


