
import Foundation

struct UserManager {
    
    let apiManager: APIManager
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    func register(phone: String?, password: String?) throws {
        
        guard let phone = phone,
              let password = password else {
            return
        }
        
        let user = User(phone: phone, password: password)
        
        apiManager.registerUser(user, completion: { result in
            switch result {
            case .success:
                self.onSuccess?()
            case .failure(let error):
                self.onFailure?(error.description)
            }
        })
    }
    
    func login(phone: String?, password: String?) throws {
      
        guard let phone = phone,
              let password = password else {
            return
        }
        apiManager.getUser(by: phone, completion: { result in
            switch result {
            case .success(let user):
                self.onSuccess?()
            case .failure(let error):
                self.onFailure?(error.description)
            }
        })
    }
}
