


import Foundation
import UIKit

class SendMoneyViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var amountTextfield: UITextField!
    @IBOutlet private weak var subjectTextfield: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    weak var delegate: AddMoneyViewControllerDelegate?
    var currentAccount: AccountResponse?
    let apiManager = APIManager()
    

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
    
    func sendMoney() {
        
    }
    
    
    
    
}









extension SendMoneyViewController {
    
    func display(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false

    }
}
