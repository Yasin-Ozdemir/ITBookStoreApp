//
//  UserViewModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 2.04.2024.
//

import Foundation
protocol IUserViewModel {
    func logOut()
    func viewDidLoad()
    func changeTheme()
    func goBackLogin()
    var delegate : IUserViewController? {get set}
}
class UserViewModel : IUserViewModel {
    private var firebaseManager : IAuthManager!
    weak var delegate : IUserViewController?
    init(firebaseManager: IAuthManager!) {
        self.firebaseManager = firebaseManager

    }
    func viewDidLoad(){
        delegate?.setupNavigationController()
        delegate?.viewAddSubviews()
        delegate?.setupConstraints()
    }
    func changeTheme(){
        ThemeManager.toggleTheme()
    }
    func logOut(){
        firebaseManager.logOut()
    }
    func goBackLogin(){
        delegate?.goBackLogin()
    }
}
