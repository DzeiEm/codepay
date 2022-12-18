

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func logoutBUttonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
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
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
        
        guard let recentTransactionCell = cell as? TransactionCell else {
            return cell
        }
        
        recentTransactionCell.configureCell(receiver: "Receiver", subject: "Subject", date: "2022-12-12", amount: 200)
        return recentTransactionCell
        
    }

}
