

import Foundation

enum LoginErrors: Error {
    
    case incorrectCredentials
    case empty
    
    var error: String {
        switch self {
        case .incorrectCredentials:
            return "User name or password is incorect"
        case .empty:
            return "Textfields cannot be empty"
        }
    }
}
