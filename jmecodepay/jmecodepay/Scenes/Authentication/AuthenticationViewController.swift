
import Foundation
import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    let settings = UIConfiguration()
    
    
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
        settings.configureButton(loginButton)
        settings.configureButton(registerButton)
    }
}
