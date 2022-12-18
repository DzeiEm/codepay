
import Foundation

enum SendMoneyErrors: Error {
    
    case amountLowerthanZero
    case amountIsEmpty
    case amountExceedBalance
    case subjectTextfieldempty
    case unexpecteerError
    case sendZero
    
    var description: String {
        switch self  {
        case .amountLowerthanZero:
            return "Sent amount cannot be lower than zero"
        case .amountIsEmpty:
            return "Amount textfield cannot be empty "
        case .amountExceedBalance:
            return "You cannot send more than you have "
        case .subjectTextfieldempty:
            return "Subject cannot be empty"
        case .sendZero:
            return "You cannot send zero money"
        case .unexpecteerError:
            return "Something unexpected happened"
        }
    }
}
