

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
    weak var delegate: AddMoneyViewControllerDelegate?
    
    var currency = ["EUR", "USD", "GBP"]
    private var selectedAccount = ""
   
    
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
        do {
            try isAmountValid(amountTextfield.text)
        } catch let amountError as AddMoneyErrors {
            displayAlert(message: amountError.message)
        } catch {
            print("somthing happened")
        }
        addMoney()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
}


extension AddMoneyViewController {
    
    func display(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        errorLabel.textColor = .red
    }
    
    
    func isAmountValid(_ amount: String?) throws -> Double{
        var setAmount = amount
        
        guard let setAmount = amountTextfield.text,
              let account = account
        else {
            throw AddMoneyErrors.amountTextfieldEmpty
        }
        
        if Double(setAmount) == 0 {
            throw AddMoneyErrors.amountEqualsZero
        }
        if Double(setAmount)! < 0 {
            throw AddMoneyErrors.amountLoverThanZero
        }
        if Double(setAmount)! > account.balance {
            throw AddMoneyErrors.amountExceedBalance
        }
        return Double(setAmount)!
    }
    
}

extension AddMoneyViewController {
    
    func addMoney() {
        guard let account = account,
              let amountInput = amountTextfield.text else {
            return
        }
        
        let amount = Double(amountInput)
        apiManager.updateUserAccount(account: account,
                                     phoneNumber: nil,
                                     currency: nil, amount: amount) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.displayAlert(message: error.apiErrorMessage)
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
                    self?.displayAlert(message: error.apiErrorMessage)
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
            let loginScreen = LoginViewController()
            loginScreen.modalPresentationStyle = .fullScreen
            self.present(loginScreen, animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
