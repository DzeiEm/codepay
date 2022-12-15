
import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var loginBUtton: UIButton!
    let settings = UIConfiguration()
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func loginButtonTapped() {
       
    }
    
    override func viewDidLoad() {
        self.viewDidLoad()
        settings.configureButton(loginBUtton)
    }
    
}
