

import Foundation

class InputData {
    
    func validatePhone(_ number: String) throws {
        
        // Search phone in between all users
        
        guard number != nil else {
            return
        }
        
    }
    
    func validateInput(amount: Double) throws {
        // Need to know balance
        
//        var balance = 100
//        if amount.description.isEmpty {
//            throw SendMoneyErrors.amountIsEmpty
//        }
//        
//        switch amount {
//        case amount < 0:
//            return SendMoneyErrors.amountLowerthanZero
//        case amount > balance:
//            return SendMoneyErrors.amountExceedBalance
//        default: return SendMoneyErrors.unexpecteerError
//        }
    }
    
    
    func validateSubject(_ text: String) throws {
        
    }
}
