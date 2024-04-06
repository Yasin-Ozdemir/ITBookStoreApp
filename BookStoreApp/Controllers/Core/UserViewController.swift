//
//  UserViewController.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 29.03.2024.
//

import UIKit
protocol IUserViewController : AnyObject{
    func goBackLogin()
    func setupNavigationController()
    func viewAddSubviews()
    func setupConstraints()
}
class UserViewController: UIViewController {
    private var viewModel : IUserViewModel = UserViewModel(firebaseManager: AuthManager())
    private let logOutButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Log Out", for: UIControl.State.normal)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.layer.cornerRadius = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    @objc func logOut(){
        viewModel.logOut()
        viewModel.goBackLogin()
    }
    @objc func changeTheme(){
        viewModel.changeTheme()
    }
}

extension UserViewController : IUserViewController {
    func setupConstraints(){
        NSLayoutConstraint.activate([
        
            self.logOutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.logOutButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            self.logOutButton.widthAnchor.constraint(equalToConstant: 180),
            self.logOutButton.heightAnchor.constraint(equalToConstant: 50),
        
        ])
    }
    func viewAddSubviews(){
        view.addSubview(logOutButton)
    }
    func goBackLogin() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
    
    func setupNavigationController(){
        self.navigationItem.title = "User Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "gear"), style: UIBarButtonItem.Style.done, target: self, action: nil), UIBarButtonItem(title: "Change Theme", style: UIBarButtonItem.Style.done, target: self, action: #selector(changeTheme))]
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    
}
