//
//  LoginViewModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 29.03.2024.
//

import Foundation

protocol ILoginViewModel{
    func viewDidLoad()
    func goCreateVC()
    func logIn(mail : String , password : String)
    func navigationItemSetup()
    var delegate : ILogInViewController? { get set }
}
class LoginViewModel{
    
    weak var delegate : ILogInViewController?
    var firebaseManager : IAuthManager?
    init(firebaseManager: IAuthManager? = nil) {
        self.firebaseManager = firebaseManager
    }
}

extension LoginViewModel : ILoginViewModel{
    func viewDidLoad() {
        delegate?.viewDidLoaded()
        navigationItemSetup()
        
    }
    
    func goCreateVC() {
        delegate?.pushCreateAccountVC()
    }
    
    func logIn(mail : String , password : String ) {
        firebaseManager?.logIn(mail: mail, password: password, completion: {[weak self] result in
            guard let self = self else{
                return
            }
            
            switch result {
            case.success(_) : delegate?.goMainTabBar()
            case.failure(let err) : delegate?.presentAlert(message: err.localizedDescription)
            }
        })
    }
    
    func navigationItemSetup() {
        delegate?.navigationItemSetup()
    }
    
    
}
