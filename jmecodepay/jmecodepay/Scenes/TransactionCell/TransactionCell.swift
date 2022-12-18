
import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountlabel: UILabel!
    
    func configureCell(receiver: String, subject: String, date: String, amount: Double) {
        receiverLabel.text = receiver
        subjectLabel.text = subject
        dateLabel.text = date
        amountlabel.text = String(amount)
    }
}

