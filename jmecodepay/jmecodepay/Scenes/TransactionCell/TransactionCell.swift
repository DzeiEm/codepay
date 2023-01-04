
import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet private weak var receiverLabel: UILabel!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var amountlabel: UILabel!
    
    
    
    func configureCell(receiver: String, subject: String, date: Int, amount: Double, account: AccountResponse) {
        
        var formatedDate = TimeInterval(date)
        
        
        receiverLabel.text = "Receiver: \(receiver)"
        subjectLabel.text = "\(subject)"
        dateLabel.text = "\(formatedDate)"
        
        if account.phoneNumber == receiver {
            amountlabel.text = "+ \(amount), \(account.currency)"
            amountlabel.textColor = .green
        } else {
            amountlabel.text = "- \(amount), \(account.currency)"
            amountlabel.textColor = .red
        }
    }
}

