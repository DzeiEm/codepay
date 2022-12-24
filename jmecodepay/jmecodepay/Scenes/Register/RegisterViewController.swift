
import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var confirmPasswordTextfield: UITextField!
    @IBOutlet private weak var currencyAccountSegmentControl: UISegmentedControl!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    
    
    let validate = RegistrationValidation()
    let apiManager = APIManager()
    let userManager = UserManager()
    var currency = ["EUR", "USD", "GBP"]
    private var availableTextFields: [UITextField] = []
    private var  selectedAccount = ""
    
    var users = [User]()
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonTapped() {
        selectedAccount = setupCurrencyAccount()
        
        do {
            let user = try? validate.isEmptyFields(phone: phoneNumberTextfield.text,
                                                   password: passwordTextfield.text,
                                                   confirmPassword: confirmPasswordTextfield.text)
            
            
            
            
            displayAlert()
            
        } catch let registrationError as RegistrationError {
            displayError(message: registrationError.error)
            
        } catch let error{
            displayError(message: error.localizedDescription )
        }
        
    }
    
    override func viewDidLoad() {
        configureInitailView()
        
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
    
    func setupCurrencyAccount() -> String{
        switch currencyAccountSegmentControl.selectedSegmentIndex {
        case 0:
            return currency[0]
        case 1:
            return currency[1]
        case  2:
            return currency[2]
        default:
            return "EUR"
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
    
    fileprivate func navigateToHomeScreen() {
        let homeSceen = HomeViewController()
        homeSceen.modalPresentationStyle = .fullScreen
        present(homeSceen, animated: true)
    }
    
}

extension RegisterViewController {
    
    func registerUser(phoneNumber: String, password: String) {
        func createUser() {
            apiManager.createUser(phoneNumber: phoneNumber, password: password) { [weak self] result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.displayError(message: error.description)
                    }
                case .success(let user):
                    print(user)
//                    self?.getUserToken(user: user)
                }
            }
            apiManager.createAccount(phoneNumber: phoneNumber, currency: "EUR") { [weak self] result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.displayError(message: error.description)
                    }
                case .success(let account):
                    DispatchQueue.main.async {
                        self?.navigateToHomeScreen()
                    }
                }
            }
        }
        apiManager.isAccountIsTaken(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                switch error {
                case .userNotFound:
                    createUser()
                default:
                    DispatchQueue.main.async {
                        self?.displayError(message: error.description)
                    }
                }
            case .success:
                DispatchQueue.main.async {
//                    self?.displayError(message: )
                }
            }
        }
        
    }
    
}
