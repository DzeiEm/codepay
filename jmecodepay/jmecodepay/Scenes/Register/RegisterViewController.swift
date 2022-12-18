
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
    let userManager = UserManager(apiManager: APIManager.init())
    let dropdown = DropDown()
    var currency = ["EUR", "USD", "GBP"]
    private var availableTextFields: [UITextField] = []
    

    @IBAction func showDropDownOptions() {
        dropdown.show()
    }
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonTapped() {
        
        do {
            var passedData = try? validate.isEmptyFields(phone: phoneNumberTextfield.text,
                                                         password: passwordTextfield.text,
                                                         confirmPassword: confirmPasswordTextfield.text,
                                                         account: seledtedLabel.text)
            
            try userManager.register(phone: passedData?.phone,
                                     password: passedData?.password)
            
        } catch let error {
            displayError(message: error.localizedDescription)
        } catch {
    
            print("something")
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
//        registerButton.isHidden = false
    }
    
    fileprivate func displayError(message: String) {
        errorLabel.isHidden = false
        errorLabel.textColor = .red
        errorLabel.text = message
    }
}


