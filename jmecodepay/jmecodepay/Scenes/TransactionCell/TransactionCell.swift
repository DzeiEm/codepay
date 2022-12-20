
import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet private weak var receiverLabel: UILabel!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var amountlabel: UILabel!
    
    func configureCell(receiver: String, subject: String, date: String, amount: Double) {
        receiverLabel.text = receiver
        subjectLabel.text = subject
        dateLabel.text = date
        amountlabel.text = String(amount)
    }
}

