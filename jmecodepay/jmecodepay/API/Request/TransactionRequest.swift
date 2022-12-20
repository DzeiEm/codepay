
import Foundation

struct TransactionRequest: Encodable {
    
    let senderId: String
    let receiverId: String
    let amount: Double
    let currency: String
    let createdOn: Double
    let reference: String
}

