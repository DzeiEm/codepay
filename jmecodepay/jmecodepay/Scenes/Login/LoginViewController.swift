
import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    let userManager = UserManager(apiManager: APIManager.init())
    let validate = LoginValidation()
    
    
    // TODO:
   // 1. validatee txt input
   //2. validate input with set data

    
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonTapped() {
        do {
            
           let userData = try? validate.isLoginTextfieldsEmpty(passwordTextfield.text, passwordTextfield.text)
            try? userManager.login(phone: userData?.phoneNumber, password: userData?.password)
            // if input matches registered user data
          navigateToHome()
        } catch let loginError as LoginErrors {
            display(message: loginError.error )
        }
    }
    
    override func viewDidLoad() {
        configureButton(loginButton)
        errorLabel.isHidden = true
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
    
    fileprivate func navigateToHome() {
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
}
