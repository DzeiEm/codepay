

import Foundation
import UIKit

class AllTransactionViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    var currrentUserAccount: AccountResponse?
    let apiManager = APIManager()
    var parsedTransactions = [TransactionResponse]()
   
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        setupTableView()
        
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
        print("already")
    }
    
    func setTransactions(_ transactions: [TransactionResponse]) {
        parsedTransactions = transactions
    }
    
    
    func configureCell() {
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
}


extension AllTransactionViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if parsedTransactions.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTransactionCell", for: indexPath)

            guard let emptyCell = cell as? EmptyTransactionCell else {
                return cell
            }
            emptyCell.configure()

            return emptyCell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
            
            guard let transactionCell = cell as? TransactionCell else {
                return cell
            }
            
        

            transactionCell.configureCell(receiver: parsedTransactions[indexPath.row].receiverId,
                                          subject: parsedTransactions[indexPath.row].reference,
                                          date: parsedTransactions[indexPath.row].createdOn,
                                          amount: Double(parsedTransactions[indexPath.row].amount!),
                                          account: currrentUserAccount!)
            
            return transactionCell
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var userTransactions = parsedTransactions
        
        if userTransactions.count == 0 {
            configureEmptyCell()
            return 1
        } else {
            configureCell()
            return userTransactions.count
        }
        
    }
}
