
import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func loginButtonTapped() {
       
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
}
