
import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet private weak var receiverLabel: UILabel!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var amountlabel: UILabel!
    
    
    
    func configureCell(receiver: String, subject: String, date: Int, amount: Double, account: AccountResponse) {
        
        
        let date = Date()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        
        var createOn = dateFormatter.string(from: date)
     
        
        
        receiverLabel.text = "Receiver: \(receiver)"
        subjectLabel.text = "\(subject)"
        dateLabel.text = "\(createOn)"
        
        if account.phoneNumber == receiver {
            amountlabel.text = "+ \(amount), \(account.currency)"
            amountlabel.textColor = .green
        } else {
            amountlabel.text = "- \(amount), \(account.currency)"
            amountlabel.textColor = .red
        }
    }
}

