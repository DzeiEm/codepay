

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
        try? isAmountValid(amountTextfield.text)
    }
}


extension AddMoneyViewController {
    
    func display(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        errorLabel.textColor = .red
    }
    

    func isAmountValid(_ amount: String?) throws -> Double{
        
        guard let amount = amountTextfield.text else {
            throw AddMoneyErrors.amountTextfieldEmpty
        }
        
        if Double(amount) == 0 {
            throw AddMoneyErrors.amountEqualsZero
        }
        if Double(amount)! < 0 {
            throw AddMoneyErrors.amountLoverThanZero
        }
        return Double(amount)!
    }
    
    func updateAccount(_ amount: Double) {
        
//        apiManager.updateUserAccount(account: selectedAccount,
//                                     phoneNumber: nil,
//                                     currency: nil,
//                                     amount: amount) { [weak self] result in
//
//            switch result {
//            case .success:
//                DispatchQueue.main.sync {
//                    self?.displayAlert()
//                    self.delegate?.onBalanceChange()
//                }
//            case .failure(let error):
//                DispatchQueue.main.sync {
//                    self.displayAlert()
//                }
//            }
//
//        }
        
    }
    
    func sendMoney() {
        
    }
}


extension AddMoneyViewController {
    
    fileprivate func displayAlert() {
        let alert = UIAlertController(title: "Success",
                                      message: "Money has been added",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let loginScreen = LoginViewController()
            loginScreen.modalPresentationStyle = .fullScreen
            self.present(loginScreen, animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
