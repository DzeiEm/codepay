
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
    let userManager = UserManager()
    let dropdown = DropDown()
    var currency = ["EUR", "USD", "GBP"]
    private var availableTextFields: [UITextField] = []
    
    var users = [User]()
    
    @IBAction func showDropDownOptions() {
        dropdown.show()
    }
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonTapped() {
        
        do {
            let userData = try? validate.isEmptyFields(phone: phoneNumberTextfield.text,
                                                       password: passwordTextfield.text,
                                                       confirmPassword: confirmPasswordTextfield.text,
                                                       account: seledtedLabel.text)
            
            var account = AccountRequest(phoneNumber: userData?.phone, currency: userData?.account)
            try? userManager.registerUser(phone: userData?.phone, password: userData?.password)
            try? userManager.createAccount(account: account)
            displayAlert()
            
        } catch let registrationError as RegistrationError {
            displayError(message: registrationError.error)
            
        } catch let error{
            displayError(message: error.localizedDescription )
        }
            
            
            
            
        
    }
    
    override func viewDidLoad() {
        configureInitailView()
        configureDopdown()
    }
}


extension RegisterViewController: UITextFieldDelegate {
    
    
    internal func textFieldDidChangeSelection(_ textField: UITextField) {
        configureRegistrationButton()
    }
    
    fileprivate func clearAllTextfields() {
        phoneNumberTextfield.text = nil
        passwordTextfield.text = nil
        confirmPasswordTextfield.text = nil
    }
    
    fileprivate func setTextfieldsDelegates() {
        phoneNumberTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmPasswordTextfield.delegate = self
    }
    
    fileprivate func configureInitailView() {
        errorLabel.isHidden = true
        registerButton.isEnabled = true
        registerButton.layer.cornerRadius = 20
    }
    
    fileprivate func configureDopdown() {
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
    
    fileprivate func configureRegistrationButton() {
        let allTextFieldsFilled = availableTextFields.allSatisfy { textField in
            guard let text = textField.text else { return false }
            return !text.isEmpty
        }
    }
    
    fileprivate func displayError(message: String) {
        errorLabel.isHidden = false
        errorLabel.textColor = .red
        errorLabel.text = message
    }
    
    fileprivate func displayAlert() {
        let alert = UIAlertController(title: "Success",
                                      message: "User has been sucessfully registered",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let loginScreen = LoginViewController()
            loginScreen.modalPresentationStyle = .fullScreen
            self.present(loginScreen, animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}


