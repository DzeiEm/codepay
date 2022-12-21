

import Foundation

struct AccountResponse: Decodable {
    
    let id: String
    let phoneNumber: String
    let currency: String
    let balance: Double
    
}
