
import Foundation

class UserManager {
    
    let apiManager = APIManager()
    var users = [User]()
    var accounts = [AccountResponse]()
//    var onSuccess: (() -> Void)?
//    var onFailure: ((String) -> Void)?
//
    func registerUser(phone: String?, password: String?) throws {
        
        guard let phone = phone,
              let password = password else {
            return
        }
        
        var user = User(phoneNumber: phone, password: password)
        
        apiManager.createUser(user, { [ weak self ] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.sync {
                    print(error)
                }
            case .success(let user):
                self?.users.append(user)
            }
        })
    }
    
    func createAccount(account: AccountResponse?) throws {
        guard let account = account else {
            return
        }
        
        apiManager.createAccount(account, { [ weak self ] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            case .success(let account):
                self?.accounts.append(account)
            }
        })
    }
    
    
    
    
    
    func fetchUsers() {
        
        apiManager.getAllUsers(completion: { result in
            switch result {
            case .success(let user):
                print("USER:\(user)")
                self.users.append(contentsOf: user)

            case .failure(let error):
//                self?.onFailure?(error.description)
                print(error)
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
                print(user)
            case .failure(let error):
                //self.onFailure?(error.description)
                print(error)
            }
        })
    }
    
    
    
}
