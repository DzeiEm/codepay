

import Foundation
import UIKit

class AddMoneyViewController: UIViewController {
    
    
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @IBAction func addMoneyButtonTapped() {
        var amountInput = amountTextfield.text
        
        guard let amountInput = amountInput else {
            return
        }
        
        
        

    }
    
}


extension AddMoneyViewController {
    
    func display(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        errorLabel.textColor = .red
    }
    
    func isValid(_ input: Double) throws -> Bool {
        
        // Should know about my balance
        
        var balance = 100
        
        switch input {
        case input == 0:
            throw SendMoneyErrors.sendZero
        case input > balance {
            throw SendMoneyErrors.amountIsEmpty
        default:
            throw SendMoneyErrors.unexpecteerError
        }
        return true
    }
}
