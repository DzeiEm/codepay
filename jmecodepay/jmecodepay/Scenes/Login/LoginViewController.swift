
import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    let apiManager = APIManager()
    let accountManager = AccountManager()
    let userManager = UserManageer()
    
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonTapped() {
        
        guard let phone = phoneNumberTextfield.text,
              let password = passwordTextfield.text,
              !phone.isEmpty,
              !password.isEmpty else {
            display(message: AccountManager.AccountManagerError.fieldsAreEmpty.errorMessage)
            return
        }
        
        loginUser(phoneNumber: phone, password: password)
    }
    
    override func viewDidLoad() {
        configureButton(loginButton)
        errorLabel.isHidden = true
    }
}


extension LoginViewController {
        
    func loginUser(phoneNumber: String, password: String) {
        
        apiManager.checkIsUserExist(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.sync {
                    self?.display(message: error.apiErrorMessage)
                }
            case .success(let user):
                DispatchQueue.main.sync {
                    guard let checkPassword = self?.accountManager.checkIsPasswordMatch(password: password, user: user) else {
                        return
                    }
                    if checkPassword {
                        isAccountExist()
                    } else {
                        self?.display(message: AccountManager.AccountManagerError.wrongPassword.errorMessage)
                    }
                }
            }
        }
        
        func isAccountExist() {
            apiManager.checkIsAccountExist(phoneNumber: phoneNumber) { [weak self] result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.sync {
                        self?.display(message: error.apiErrorMessage)
                    }
                case .success(let account):
                    DispatchQueue.main.sync {
                        self?.navigateToHome(account)
                    }
                }
            }
        }
    }
}

extension LoginViewController {
    
    fileprivate func configureButton(_ button: UIButton)  {
        button.layer.cornerRadius = 20
    }
    
    fileprivate func display(message: String) {
        errorLabel.text = message
        errorLabel.textColor = .red
        errorLabel.isHidden = false
    }
    
    fileprivate func navigateToHome(_ account: AccountResponse) {
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
}
