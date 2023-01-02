
import Foundation
import KeychainSwift

struct UserManageer {
    
    private let userDefaults = UserDefaults.standard
    private let keyChain = KeychainSwift()
    
    private enum UserManagerKey {
        static let userPhoneNumber: String = "phone number"
        static let tokenExpiration: String = "token expiration"
    }
    
    func getUserPhoneNumber() -> String? {
        return userDefaults.object(forKey: UserManagerKey.userPhoneNumber) as? String
    }
    
    func saveUserPhoneNumber(phoneNumber: String) {
        userDefaults.setValue(phoneNumber, forKey: UserManagerKey.userPhoneNumber)
    }
    
    func getTokenExpirationDate() -> Int? {
        return userDefaults.object(forKey: UserManagerKey.tokenExpiration) as? Int
    }
    
    func saveTokenEexpiration(_ expiration: Int) {
        userDefaults.setValue(expiration, forKey: UserManagerKey.tokenExpiration)
    }
    
    func saveToken(_ token: String, phoneNumber: String) {
        keyChain.set(token, forKey: phoneNumber)
    }
    
    func getToken(phoneNumber: String) -> String? {
        keyChain.get(phoneNumber)
    }
    
    func isLoggedIn() -> Bool {
        guard let phoneNumber = getUserPhoneNumber(),
              let _ = getToken(phoneNumber: phoneNumber),
              let tokenExpiration = getTokenExpirationDate() else {
            return false
        }
        
        let currentTimeStamp = Date().timeIntervalSince1970
        return tokenExpiration > Int(currentTimeStamp)
    }
}
