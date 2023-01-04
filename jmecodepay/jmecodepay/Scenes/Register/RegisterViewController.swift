
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
    let userManager = UserManageer()
    var currency = ["EUR", "USD", "GBP"]
    private var selectedAccount = "EUR"
    
    override func viewDidLoad() {
        configureInitailView()
        clearAllTextfields()
    }
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSegmentControlTypeChanged(_ sender: Any) {
        switch currencyAccountSegmentControl.selectedSegmentIndex {
        case 0:
            selectedAccount = currency[0]
        case 1:
            selectedAccount = currency[1]
        case  2:
            selectedAccount = currency[2]
        default:
            break
        }
    }
    
    @IBAction func registerButtonTapped() {
        guard let phone = phoneNumberTextfield.text,
              let password = passwordTextfield.text,
              let confirmPassword = confirmPasswordTextfield.text,
              !phone.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else {
            displayError(message: AccountManager.AccountManagerError.fieldsAreEmpty.errorMessage )
            return
        }
        
        do {
            try validate.isPasswordsMatch(password: password, confirmPassword: confirmPassword)
            try validate.isPasswordSecure(password: password)
        }
        catch let passwordError as RegistrationError {
            displayError(message: passwordError.errorMessage)
            return
        } catch {
            displayError(message: RegistrationError.unexpecteerError.errorMessage)
            return
        }
        registerUser(phoneNumber: phone, password: password)
    }
}


extension RegisterViewController {
    func registerUser(phoneNumber: String, password: String) {
        apiManager.checkIsAccountExist(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                switch error {
                case .userNotFound:
                    print("User not found")
                    createUser()
                default:
                    DispatchQueue.main.async {
                        self?.displayError(message: error.apiErrorMessage)
                    }
                }
            case .success:
                DispatchQueue.main.async {
                    self?.displayError(message: AccountManager.AccountManagerError.accountAlreadyExists.errorMessage)
                }
            }
        }
        
        func createUser() {
            apiManager.createUser(phoneNumber: phoneNumber, password: password) { [weak self] result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.displayError(message: error.apiErrorMessage)
                    }
                case .success(let user):
                    print("create user func \(user)")
                    self?.getUserToken(user: user)
                }
            }
            apiManager.createAccount(phoneNumber: phoneNumber, currency: selectedAccount) { [weak self] result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.displayError(message: error.apiErrorMessage)
                    }
                case .success(let account):
                    print(account)
                    DispatchQueue.main.async {
                        self?.displayAlert()
                        self?.navigateToLoginScreen()
                    }
                }
            }
        }
    }
    
    func getUserToken(user: User) {
        apiManager.getToken(user: user) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.sync {
                    self?.displayError(message: error.apiErrorMessage)
                }
            case .success(let token):
                print(token)
                self?.userManager.saveToken(token.accessToken, phoneNumber: user.phoneNumber)
                self?.userManager.saveUserPhoneNumber(phoneNumber: user.phoneNumber)
                
            }
        }
    }
}


extension RegisterViewController {
    func clearAllTextfields() {
        phoneNumberTextfield.text = ""
        passwordTextfield.text = ""
        confirmPasswordTextfield.text = ""
    }
    
    func configureInitailView() {
        errorLabel.isHidden = true
        registerButton.layer.cornerRadius = 10
    }
    
    func displayError(message: String) {
        errorLabel.isHidden = false
        errorLabel.textColor = .red
        errorLabel.text = message
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "Success",
                                      message: "User has been sucessfully registered",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//            let loginScreen = LoginViewController()
//            loginScreen.modalPresentationStyle = .fullScreen
//            self.present(loginScreen, animated: true)
            self.navigateToLoginScreen()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToLoginScreen() {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen, animated: true)
    }
}
