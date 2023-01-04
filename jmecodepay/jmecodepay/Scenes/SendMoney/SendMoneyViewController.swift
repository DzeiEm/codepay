


import Foundation
import UIKit

class SendMoneyViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var amountTextfield: UITextField!
    @IBOutlet private weak var subjectTextfield: UITextField!
    @IBOutlet private weak var accountCurrencySegmentControlLabel: UISegmentedControl!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var sendMoneyButton: UIButton!
    
    weak var delegate: AddMoneyViewControllerDelegate?
    var currentAccount: AccountResponse?
    let apiManager = APIManager()
    let currency = ["EUR", "USD", "GBP"]
    private var selectedAccount = "EUR"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        configureButtonView()
    }
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @IBAction func sendButtonTapped() {
        sendMoney()
    }
    
    @IBAction func onSegmentControlChange() {
        switch accountCurrencySegmentControlLabel.selectedSegmentIndex {
        case 0:
            selectedAccount = currency[0]
        case 1:
             selectedAccount = currency[1]
        case  2:
             selectedAccount = currency[2]
        default:
            break
        }
    }
}


extension SendMoneyViewController {
    
    func display(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        errorLabel.textColor = .red
    }
    
    func sendMoney() {
        guard let currentAccount = currentAccount,
              let phoneNumber = phoneNumberTextfield.text,
              let subject = subjectTextfield.text
        else {
            return
        }
        
        apiManager.checkIsAccountExist(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self?.display(message: error.apiErrorMessage)
                }
            case .success(let account):
                DispatchQueue.main.async {
                    guard let amount = self?.amountTextfield.text else {
                        return
                    }
                    if currentAccount.currency == account.currency &&
                        Double(amount)! <= currentAccount.balance &&
                        Double(amount)! > 0 {
                        sendMoneyRequest(account: account)
                    } else {
                        self?.displayAlert(message: "Insuficient funds or acurrency")
                    }
                }
            }
        }
        
        func sendMoneyRequest(account: AccountResponse) {
            apiManager.sendMoney(sender: currentAccount,
                                 receiver: account,
                                 amount: Double(amountTextfield.text!),
                                 currency: currentAccount.currency,
                                 reference: subject) { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                   self?.display(message: error.apiErrorMessage)
                case .success:
                    DispatchQueue.main.async {
                        self?.displayAlert(message: "Transaction completed")
                    }
                }
            }
            
            apiManager.updateUserAccount(account: account,
                                         phoneNumber: nil,
                                         currency: nil,
                                         amount: Double(amountTextfield.text!)!) { [weak self] result in
                
                switch result {
                case .failure(let error):
                    print("SEND MONEY CONTROLLER, update user acc \(error)")
                    self?.display(message: error.apiErrorMessage)
                case .success:
                    print("All good, updated")
                }
            }
            
            apiManager.updateUserAccount(account: currentAccount,
                                         phoneNumber: nil,
                                         currency: nil,
                                         amount: (-Double(amountTextfield.text!)!)) { [weak self] result in
                switch result {
                case .failure(let error):
                    print("SEND MONEY CONTROLLER, update user acc 2 \(error)")
                   self?.display(message: error.apiErrorMessage)
                case .success:
                    self?.delegate?.onBalanceChange()
                }
            }
        }
    }
}


extension SendMoneyViewController {
    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Success",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigateToHomeScreen()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToHomeScreen() {
        self.dismiss(animated: true)
    }
    
    func configureButtonView() {
        sendMoneyButton.layer.cornerRadius = 10
    }
}
