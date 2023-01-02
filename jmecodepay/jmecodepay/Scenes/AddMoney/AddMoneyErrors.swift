
import Foundation


enum AddMoneyErrors: Error {
    
    case amountLoverThanZero
    case amountExceedBalance
    case amountTextfieldEmpty
    case amountEqualsZero
    
    var message: String {
        switch self {
        case .amountLoverThanZero:
            return "Amount cannot be lover than zero"
        case .amountExceedBalance:
            return "Amoount cannot exceed balance"
        case .amountTextfieldEmpty:
            return "Amount textfield cannot be empty"
        case .amountEqualsZero:
            return "NO point to send zero amount"
        }
    }
}
