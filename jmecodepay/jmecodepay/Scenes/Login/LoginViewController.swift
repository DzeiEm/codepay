
import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    let userManager = UserManager()
    let validate = LoginValidation()
    
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func loginButtonTapped() {
        do {
            
           let userData = try? validate.isLoginTextfieldsEmpty(passwordTextfield.text, passwordTextfield.text)
            try? userManager.login(phone: userData?.phone, password: userData?.password)
          

            
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
    
    func display(message: String) {
        errorLabel.text = message
        errorLabel.textColor = .red
        errorLabel.isHidden = false
    }
}
