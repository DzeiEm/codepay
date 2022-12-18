
import Foundation

class RegistrationValidation {
    
    func isEmptyFields(phone: String?, password: String?, confirmPassword: String?, account: String?) throws -> UserData {
        guard let phone = phone,
              let password = password,
              let confirmPassword = confirmPassword,
              let account = account,
              !phone.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty,
              !account.isEmpty
        else {
            throw RegistrationError.unexpecteerError
        }
        
        try isPasswordsMatch(password: password, confirmPassword: confirmPassword)
        try isPasswordValid(password)
        
        return UserData(phone: phone,
                    password: password,
                    confirmPassword: confirmPassword,
                    account: account)
    }
    
    func isPasswordsMatch(password: String, confirmPassword: String) throws {
       if password != confirmPassword {
           throw RegistrationError.passwodDoNotMAtch
       }
       return
   }
    
    func isPasswordValid(_ password: String?) throws {
        guard let password = password else {
            return
        }
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
    
    func isPhoneNumberUnique(_ phone: String) throws {
      // GET
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

