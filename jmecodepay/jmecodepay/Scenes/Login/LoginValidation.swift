
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
        
        return User(phone: phone, password: password)
    }
}
