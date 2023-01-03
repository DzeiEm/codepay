

import Foundation
import UIKit

class AllTransactionViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    var currrentUserAccount: AccountResponse?
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("already")
    }
    
}
