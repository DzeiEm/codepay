
import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet private weak var receiverLabel: UILabel!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var amountlabel: UILabel!
    
    
    
    func configureCell(receiver: String, subject: String, date: Int, amount: Double, account: AccountResponse) {
        receiverLabel.text = "\(receiver)"
        
        if account.phoneNumber == receiver {
            amountlabel.text = "+ \(amount)"
            amountlabel.textColor = .green
        } else {
            amountlabel.text = "- \(amount)"
            amountlabel.textColor = .red
        }
    }
}

