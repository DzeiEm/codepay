
import Foundation

struct AccountRequest: Encodable {
    
    let phoneNumber: String
    let currency: String
    let balance: Double
}
