

import Foundation
import UIKit

class AllTransactionViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("already")
    }
    
}


//extension AllTransactionViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
//
//        guard let transactionCell = cell as? TransactionCell else {
//            return cell
//        }
//
//        //transactionCell.configureCell(receiver: "Receiver", subject: "Subject", date: "Date", amount: 200)
//        return transactionCell
//    }
//}
