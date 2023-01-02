
import Foundation

class RegistrationValidation {
    
//    func isEmptyFields(phone: String?, password: String?, confirmPassword: String?) throws -> User {
//        guard let phone = phone,
//              let password = password,
//              let confirmPassword = confirmPassword,
//              !phone.isEmpty,
//              !password.isEmpty,
//              !confirmPassword.isEmpty
//        else {
//            throw RegistrationError.unexpecteerError
//        }
//
//        try isPasswordsMatch(password: password, confirmPassword: confirmPassword)
//        try isPasswordValid(password)
//
//        return User(id: <#T##String#>, phoneNumber: <#T##String#>, password: <#T##String#>)
//    }
    
    
    func isPasswordsMatch(password: String, confirmPassword: String) throws {
       if password != confirmPassword {
           throw RegistrationError.passwodDoNotMAtch
       }
       return
   }
    
    func isPasswordSecure(password: String) throws  {
        guard containsNumbers(password) else {
            throw RegistrationError.containsNumbers
        }
        guard containsLowerCase(password) else {
            throw RegistrationError.containsLowerCases
        }
        guard containsUpperCase(password) else {
            throw RegistrationError.containsUpperCases
        }
        guard containsRequiredPasswordLength(password) else {
            throw RegistrationError.containsRequiredPasswordLength
        }
    }
}


extension RegistrationValidation {
    fileprivate func containsUpperCase(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isUppercase
        })
    }
    
    fileprivate func containsLowerCase(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isLowercase
        })
    }
    
    fileprivate func containsNumbers(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isNumber
        })
    }
    
    fileprivate func containsRequiredPasswordLength(_ password: String) -> Bool {
        password.count >= 8 ? true : false
    }
}

