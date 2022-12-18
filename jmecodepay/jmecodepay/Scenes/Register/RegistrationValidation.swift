
import Foundation

class RegistrationValidation {
    
    func register(phone: String, password: String)  {
        try? isPhoneNumberUnique(phone)
        try? isPasswordValid(password)
        
        
    }
    
//    func validateEmptyFields(phone: String, password: String, ) {
//
//    }
       
    
    func isPhoneNumberUnique(_ phone: String) throws {
        // get all numbersfrom API
    }
    
    func isPasswordValid(_ password: String) throws {
    
        try? isPasswordSecure(password: password)
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
    
     func isPasswordsMatch(password: String, confirmPassword: String) throws {
        if password != confirmPassword {
            throw RegistrationError.passwodDoNotMAtch
            
        }
        return
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

