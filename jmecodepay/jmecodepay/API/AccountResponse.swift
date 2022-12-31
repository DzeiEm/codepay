
import Foundation

struct AccountResponse: Codable {
    var id: String
    var phoneNumber: String
    var currency: String
    var balance: Double
}
