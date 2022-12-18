

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func logoutBUttonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func sendButtonTapped() {
    }
    
    
    @IBAction func addMoneyTapped() {
    }
    
    
    @IBAction func viewAllTransactionsTapped() {
        
    }
    
}
