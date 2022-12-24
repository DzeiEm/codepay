
import Foundation

struct TransactionResponse: Codable {
    let id: String
    let senderId: String
    let receiverId: String
    let amount: Double
    let currency: String
    let createdOn: Double
    let reference: String
}

