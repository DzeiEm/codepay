

import Foundation
import UIKit


class EmptyTransactionCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure() {
        titleLabel.text = "NO transactions made"
    }
}
    
