
import Foundation

enum  RegistrationError: Error {
    
    case passwodDoNotMAtch
    case weakPasword
    case phoneNumberAlreadyTaken
    case containsNumbers
    case containsLowerCases
    case containsUpperCases
    case containsRequiredPasswordLength
    case unexpecteerError
    
    var errorMessage: String {
        switch self {
        case .passwodDoNotMAtch:
            return "Passwords do not match 💁‍♀️"
        case .weakPasword:
            return "Password is too weak 😢"
        case .phoneNumberAlreadyTaken:
            return  "User already exist 🥵"
        case .containsNumbers:
            return "Password should contains numbers 1️⃣"
        case .containsLowerCases:
            return "Password should contains lower case letters 🔤"
        case .containsUpperCases:
            return "Password should contains upper case letters 🆙"
        case .containsRequiredPasswordLength:
            return "Password should contain at lest 8 characters 8️⃣"
        case .unexpecteerError:
            return "Unexpected error appears 😱"
        }
    }
    
    
}
