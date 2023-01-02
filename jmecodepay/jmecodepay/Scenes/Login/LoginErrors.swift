

import Foundation

enum LoginErrors: Error {
    
    case incorrectCredentials
    case empty
    
    var errorMessage: String {
        switch self {
        case .incorrectCredentials:
            return "User name or password is incorect"
        case .empty:
            return "Textfields cannot be empty"
        }
    }
}
