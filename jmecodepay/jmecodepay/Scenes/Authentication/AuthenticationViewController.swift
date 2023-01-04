
import Foundation
import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    @IBAction func loginButtonTapped() {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen, animated: true)
        
    }
    
    @IBAction func registerButtonTapped() {
        let registrationScreen = RegisterViewController()
        registrationScreen.modalPresentationStyle = .fullScreen
        present(registrationScreen, animated: true)
    }
    
    override func viewDidLoad() {
        registerButton.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
    }
}
