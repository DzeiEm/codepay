

import Foundation
import UIKit


class EmptyTransactionCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure() {
        titleLabel.text = "NO transactions made"
    }
}
    
