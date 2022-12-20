

import Foundation
import UIKit


class TransactionDetailsViewController: UIViewController {
    
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    @IBAction func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        //
    }
    
}
