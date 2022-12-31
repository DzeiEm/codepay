
import Foundation

struct UserManageer {
    
    private let userDefaults = UserDefaults.standard
    private let keyChain = KeychainSwift()
    
    private enum UserManagerKey {
        static let userPhoneNumber: String = "phone number"
        static let tokenExpiration: String = "token expiration"
    }
    
    func getUserPhoneNumber() -> String? {
        return userDefaults.object(forKey: User)
    }
    
}
