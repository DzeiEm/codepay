

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    
    var currrentUserAccount: AccountResponse?
    private var accountTransactions: [TransactionResponse]? = []
    var fetchedTransactions = [TransactionResponse]()
    private let apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransactions()
        setupTableView()
        configureButtonsView()
        reloadScreenData()
    }
    
    @IBAction func logoutBUttonTapped() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func sendButtonTapped() {
        let sendMoneyScreen = SendMoneyViewController()
        sendMoneyScreen.currentAccount = currrentUserAccount
        sendMoneyScreen.modalPresentationStyle = .fullScreen
        present(sendMoneyScreen, animated: true)
    }
    
    @IBAction func addMoneyTapped() {
        let addMoneyScreen = AddMoneyViewController()
        addMoneyScreen.account = currrentUserAccount
        addMoneyScreen.modalPresentationStyle = .fullScreen
        present(addMoneyScreen, animated: true)
    }
    
    @IBAction func viewAllTransactionsTapped() {
        let viewAllTransactionScreen = AllTransactionViewController()
        viewAllTransactionScreen.currrentUserAccount = currrentUserAccount
        viewAllTransactionScreen.modalPresentationStyle = .fullScreen
        present(viewAllTransactionScreen, animated: true)
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
    }
    
    func reloadScreenData() {
        guard let account = currrentUserAccount else { return }
        balanceLabel.text = "\(Double(account.balance)),\(account.currency)"
        tableView.reloadData()
    }
    
    func fetchTransactions() {
        guard let userAcc = currrentUserAccount else {
            return
        }
        
        apiManager.getUserTransactions(phoneNumber: userAcc.phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let userTransactions):
                self?.setTransactions(userTransactions)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                print(userTransactions)
            }
        }
    }
    
    func setTransactions(_ transactions: [TransactionResponse]) {
        fetchedTransactions = transactions
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let userTransactions = fetchedTransactions
        
        if userTransactions.count == 0 {
            configureEmptyCell()
            return 1
        } else {
            configureTransactionCell()
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fetchedTransactions.count == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTransactionCell", for: indexPath)
            guard let emptyCell = cell as? EmptyTransactionCell else {
                return cell
            }
            emptyCell.configure()
            return emptyCell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
            
            guard let transactionCell = cell as? TransactionCell else {
                return cell
            }
            
            transactionCell.configureCell(receiver: fetchedTransactions[indexPath.row].receiverId,
                                          subject: fetchedTransactions[indexPath.row].reference,
                                          date: fetchedTransactions[indexPath.row].createdOn,
                                          amount: Double(fetchedTransactions[indexPath.row].amount!),
                                          account: currrentUserAccount!)
            
            return transactionCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
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
    func displayAlert(message: String) {
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
    
    func configureButtonsView() {
        addButton.layer.cornerRadius = 10
        sendButton.layer.cornerRadius = 10
    }
}
