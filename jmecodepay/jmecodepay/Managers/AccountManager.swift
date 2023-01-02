

import Foundation

class AccountManager {
    
    let apiManager =  APIManager()
    static var loggedInAccount: Account?
  
    enum AccountManagerError: Error {
        case fieldsAreEmpty
        case accountAlreadyExists
        case wrongPassword
        case accountNotFound
        
        var errorMessage: String {
            switch self {
            case .fieldsAreEmpty:
                return "TextField cannot be empty"
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

extension AccountManager {
    
    func checkIsPasswordMatch(password: String, user: User) -> Bool {
        password == user.password
    }
    
    static func isUsernameTaken(_ username: String) -> Bool {
        return false
    }
}
