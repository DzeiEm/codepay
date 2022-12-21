
import Foundation

class LoginValidation {
    
    
    func isLoginTextfieldsEmpty(_ phone: String?, _ password: String?) throws -> User {
        
        guard let phone = phone,
              let password = password,
              !phone.isEmpty,
              !password.isEmpty
        else {
            throw LoginErrors.empty
        }
        
        return User(phoneNumber: phone, password: password)
    }
    
    func isCredentialsMatches(_ phone: String?, _ password: String?) throws -> Bool {
        
        return true
    }
}
