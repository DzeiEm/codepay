
import Foundation
import UIKit
import DropDown

class RegisterViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var confirmPasswordTextfield: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var dropdownView: UIView!
    @IBOutlet private weak var seledtedLabel: UILabel!
    
    
    
    let validate = RegistrationValidation()
    let apiManager = APIManager()
    let dropdown = DropDown()
    var currency = ["EUR", "USD", "GBP"]
    
    
    @IBAction func showDropDownOptions() {
        dropdown.show()
    }
    
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registerButtonTapped() {
        
       
    }
    
    override func viewDidLoad() {
        configureButton(registerButton)
        errorLabel.isHidden = true
        seledtedLabel.text = "Select currency"
        dropdownView.frame.size.height = 45
        dropdown.anchorView = dropdownView
        dropdown.dataSource = currency
        dropdown.bottomOffset = CGPoint(x: 0, y: 45)
        dropdown.topOffset = CGPoint(x: 0, y: 45)
        dropdown.direction = .bottom
        dropdown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.seledtedLabel.text = currency[index]
        }
    }
}


extension RegisterViewController {
    
    fileprivate func configureButton(_ button: UIButton)  {
        button.layer.cornerRadius = 20
    }
    
    fileprivate func textfieldsAreNotEmpty(phone: String?, password: String?, confirmPassword: String?) -> Bool {
        
        guard let phone = phone,
              let password = password,
              let confirmPassword = confirmPassword,
              !phone.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty
        else {
            registerButton.isEnabled = false
            return true
        }
        return false
    }
    
}
