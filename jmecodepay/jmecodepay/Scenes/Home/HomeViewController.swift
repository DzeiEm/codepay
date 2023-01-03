

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    var currrentUserAccount: AccountResponse?
    private var accountTransactions: [TransactionResponse]? = []
    private let apiManager = APIManager()
    
    @IBAction func logoutBUttonTapped() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    @IBAction func sendButtonTapped() {
        let sendMoneyScreen = SendMoneyViewController()
        sendMoneyScreen.modalPresentationStyle = .fullScreen
        present(sendMoneyScreen, animated: true)
    }
    
    
    @IBAction func addMoneyTapped() {
        let addMoneyScreen = AddMoneyViewController()
        addMoneyScreen.modalPresentationStyle = .fullScreen
        present(addMoneyScreen, animated: true)
    }
    
    
    @IBAction func viewAllTransactionsTapped() {
        let viewAllTransactionScreen = AllTransactionViewController()
        viewAllTransactionScreen.modalPresentationStyle = .fullScreen
        present(viewAllTransactionScreen, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        reloadScreenData()
        
    }
    
    func configureTransactionCell() {
        let cellNib = UINib(nibName: "TransactionCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "TransactionCell")
    }
    
    func configureEmptyCell() {
        let cellNib = UINib(nibName: "EmptyTransactionCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EmptyTransactionCell")
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
    }
    
    func reloadScreenData() {
        guard let account = currrentUserAccount else { return }
        print("ACOUNT: \(account)")
        balanceLabel.text = "\(Double(account.balance)),\(account.currency)"
        tableView.reloadData()
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var transactions = accountTransactions
        
        if transactions?.count == 0 {
            configureEmptyCell()
            return 1
        } else {
            configureTransactionCell()
            return 5
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTransactionCell", for: indexPath)
            
            guard let emptyCell = cell as? EmptyTransactionCell else {
                return cell
            }
            emptyCell.configure()
            
            return emptyCell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
           
            guard let transactionCell = cell as? TransactionCell,
                  let account = currrentUserAccount,
                  let accountTransactions = accountTransactions else {
                return cell
            }
            
            let sortedTransactions = accountTransactions.sorted { $0.createdOn > $1.createdOn }
            let transaction = sortedTransactions[indexPath.row]
            
            
            transactionCell.configureCell(receiver: transaction.receiverId,
                                          subject: transaction.reference,
                                          date: transaction.createdOn,
                                          amount: transaction.amount!,
                                          account: account)
            return transactionCell
            
        }
    }
    
}

extension HomeViewController: AddMoneyViewControllerDelegate {
    
    func onBalanceChange() {
        guard let account = currrentUserAccount else { return }
        apiManager.checkIsAccountExist(phoneNumber: account.phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.sync {
                    self?.displayAlert(message: error.apiErrorMessage)
                }
            case .success(let account):
                DispatchQueue.main.sync {
                    self?.currrentUserAccount = account
                    self?.reloadScreenData()
                }
            }
        }
        
        guard let account = currrentUserAccount else { return }
        apiManager.getUserTransactions(phoneNumber: account.phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.sync {
                    self?.displayAlert(message: error.apiErrorMessage)
                }
            case .success(let transactions):
                DispatchQueue.main.sync {
                    self?.accountTransactions = transactions
                    self?.reloadScreenData()
                }
            }
        }
    }
}




extension HomeViewController {
    func getTransactions() {
        guard let account = currrentUserAccount else { return }
        apiManager.getUserTransactions(phoneNumber: account.phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.sync {
                    self?.displayAlert(message: error.apiErrorMessage)
                }
            case .success(let transactions):
                DispatchQueue.main.sync {
                    self?.accountTransactions = transactions
                    self?.reloadScreenData()
                }
            }
        }
    }
}

extension HomeViewController {
    
    fileprivate func displayAlert(message: String) {
        let alert = UIAlertController(title: "Ooops",
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
