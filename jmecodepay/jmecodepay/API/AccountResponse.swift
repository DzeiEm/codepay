
import Foundation

struct AccountResponse: Codable {
    var id: String
    let phoneNumber: String
    let currency: String
    let balance: Double
}
