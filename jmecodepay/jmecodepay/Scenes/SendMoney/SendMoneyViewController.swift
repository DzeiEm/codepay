


import Foundation
import UIKit

class SendMoneyViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var subjectTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    

    @IBAction func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func sendButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    
}

extension SendMoneyViewController {
    
    func display(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false

    }
}
