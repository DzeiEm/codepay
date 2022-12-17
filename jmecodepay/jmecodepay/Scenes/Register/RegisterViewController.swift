
import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var phooneNumberTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
//    let settings = UIConfiguration()
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registerButtonTapped() {
    }
    
    override func viewDidLoad() {
//        settings.configureButton(registerButton)
    }
}
