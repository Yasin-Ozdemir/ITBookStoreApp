//
//  LogInViewController.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 28.03.2024.
//

import UIKit

protocol ILogInViewController : AnyObject{
    func viewDidLoaded()
    func navigationItemSetup()
    func pushCreateAccountVC()
    func logIn()
    func goMainTabBar()
    func presentAlert(message : String)
}
class LogInViewController: UIViewController {
    var viewModel  : ILoginViewModel = LoginViewModel(firebaseManager: AuthManager())
    private let logoImageView : UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "bookLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mailTextField : UITextField = {
        let txtField = UITextField()
        txtField.placeholder = " Please Enter Your Mail"
        txtField.borderStyle = .none
        txtField.keyboardType = .emailAddress
        txtField.layer.cornerRadius = 20
        txtField.layer.borderWidth = 1.5
        txtField.layer.borderColor = UIColor.secondaryLabel.cgColor
        txtField.tintColor = UIColor.secondaryLabel
        txtField.leftView = UIImageView(image: UIImage(systemName: "mail"))
        txtField.leftViewMode = .always
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private let passwordTextField : UITextField = {
        let txtField = UITextField()
        txtField.placeholder = " Please Enter Your Password"
        txtField.isSecureTextEntry = true
        txtField.borderStyle = .none
        txtField.layer.cornerRadius = 20
        txtField.layer.borderWidth = 2
        txtField.layer.borderColor = UIColor.secondaryLabel.cgColor
        txtField.tintColor = UIColor.secondaryLabel
        txtField.leftView = UIImageView(image: UIImage(systemName: "lock"))
        txtField.leftViewMode = .always
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private let createAccountButton : UIButton = {
        let button = UIButton(type:  .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: UIControl.State.normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.addTarget(self, action: #selector(goCreateAccountVC), for: .touchUpInside)
        return button
    }()
    
    private let logInButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: UIControl.State.normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondaryLabel
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    func setupConstraints(){
        NSLayoutConstraint.activate([
        
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.view.frame.height / 30),
            self.logoImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.33),
            self.logoImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.33),
            
            self.mailTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 25),
            self.mailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.mailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            self.mailTextField.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.mailTextField.bottomAnchor, constant: 25),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
        
            self.createAccountButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 35),
            self.createAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.createAccountButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            self.createAccountButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            
            self.logInButton.topAnchor.constraint(equalTo: self.createAccountButton.bottomAnchor, constant: 40),
            self.logInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logInButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            self.logInButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07)
        
        ])
    }
    
     @objc func goCreateAccountVC(){
         viewModel.goCreateVC()
    }
    @objc func logIn(){
        viewModel.logIn(mail: self.mailTextField.text! , password: self.passwordTextField.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    

}

extension LogInViewController : ILogInViewController {
    func viewDidLoaded() {
        self.view.backgroundColor = .systemBackground
        view.addSubview(logoImageView)
        view.addSubview(mailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)
        view.addSubview(logInButton)
        setupConstraints()
    }
    func navigationItemSetup(){
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "LogIn"
    }
    
    func pushCreateAccountVC(){
        let rootVc = RegisterViewController()
        self.navigationController?.pushViewController(rootVc, animated: true)
    }
    
    func goMainTabBar(){
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.checkAuthentication()
        }
        
    }
    func presentAlert(message : String){
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
}

