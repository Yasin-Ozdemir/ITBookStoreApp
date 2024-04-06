//
//  RegisterViewModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 29.03.2024.
//

import Foundation
protocol IRegisterViewModel{
    func viewDidLoad()
    func goBackLogIn()
    func createUser(mail : String , password : String)
    func navigationItemSetup()
    func presentAlert(message : String)
    var delegate : IRegisterViewController? { get set }
}
class RegisterViewModel{
    weak var delegate: IRegisterViewController?
    let firebaseManager : IAuthManager?
    init(firebaseManager: IAuthManager?) {
        self.firebaseManager = firebaseManager
    }
}

extension RegisterViewModel : IRegisterViewModel{
    func viewDidLoad() {
        delegate?.viewDidLoaded()
        navigationItemSetup()
    }
    
    func goBackLogIn() {
        delegate?.goBackLogIn()
    }
    
    func createUser(mail : String , password : String) {
        firebaseManager?.createUser(mail: mail, password: password, completion: { [weak self]result in
            guard let self = self else{
                return
            }
            switch result{
            case .success(_) : self.goBackLogIn()
            case .failure(let err) : self.presentAlert(message : err.localizedDescription)
            }
        })
    }
    
    func navigationItemSetup() {
        delegate?.navigationItemSetup()
    }
    
    func presentAlert(message : String){
        delegate?.presentAlert(message: message)
    }
}
