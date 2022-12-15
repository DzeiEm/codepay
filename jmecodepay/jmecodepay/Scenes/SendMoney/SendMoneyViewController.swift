


import Foundation
import UIKit

class SendMoneyViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var subjectTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    @IBAction func backButtonTapped() {
        let homeScreen = HomeViewController()
        homeScreen.dismiss(animated: true)
    }
    
    
    @IBAction func sendButtonTapped() {
        
    }
    
}
