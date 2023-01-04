

import Foundation
import UIKit


protocol AddMoneyViewControllerDelegate: AnyObject {
    func onBalanceChange()
}

class AddMoneyViewController: UIViewController {
    
    @IBOutlet private weak var amountTextfield: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet weak var accountCurrencySegmentControl: UISegmentedControl!
    
    let apiManager = APIManager()
    var account: AccountResponse?
    var delegate: AddMoneyViewControllerDelegate?
    
    var currency = ["EUR", "USD", "GBP"]
    private var selectedAccount = "EUR"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
   
    
    @IBAction func onAccountCurrencyChange() {
        switch accountCurrencySegmentControl.selectedSegmentIndex {
        case 0:
            print(currency[0])
             selectedAccount = currency[0]
        case 1:
            print(currency[1])
             selectedAccount = currency[1]
        case  2:
            print(currency[2])
             selectedAccount = currency[2]
        default:
            break
        }
    }
    
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @IBAction func addMoneyButtonTapped() {
      addMoney()
    }
}

extension AddMoneyViewController {
    
    func addMoney() {
        guard let amountInput = amountTextfield.text,
              let account = account
        else {
            return
        }
        
        let amount = Double(amountInput)
        apiManager.updateUserAccount(account: account,
                                     phoneNumber: nil,
                                     currency: nil,
                                     amount: amount) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.display(message: error.apiErrorMessage)
                }
            case .success:
                DispatchQueue.main.async {
                    self?.displayAlert(message: "Success! Money added")
                    self?.delegate?.onBalanceChange()
                }
            }
        }
        
        apiManager.sendMoney(sender: account,
                             receiver: account,
                             amount: amount,
                             currency: account.currency,
                             reference: "Added") { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.display(message: error.apiErrorMessage)
                }
            case .success:
                DispatchQueue.main.async {
                    self?.displayAlert(message: "Transaction completed")
                    
                }
            }
        }
    }
}

extension AddMoneyViewController {
    
    fileprivate func displayAlert(message: String) {
        let alert = UIAlertController(title: "Success",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigateBackToHomeScreen()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func display(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        errorLabel.textColor = .red
    }
    
    func navigateBackToHomeScreen() {
        self.dismiss(animated: true)
    }
}
