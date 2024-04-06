//
//  PurchaseViewController.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 29.03.2024.
//

import UIKit
protocol IPurchaseViewController : AnyObject {
    func setupConstraints()
    func presentAlert(title : String,message : String)
    func setUpNavigationController()
    func viewAddSubviews()
    func prepareTableView()
    func tableViewReload()
    func updateTableView()
    func goHomeView()
}
class PurchaseViewController: UIViewController {
    private var viewModel : IPurchaseViewModel = PurchaseViewModel(fireStoreManager: FirestoreManager())
    var orderList : [Order] = []
    private let bookTableView : UITableView = {
       let table = UITableView()
        table.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.id)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private let buyButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY", for: UIControl.State.normal)
        button.backgroundColor = .secondaryLabel
        button.setTitleColor(.label, for: UIControl.State.normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buyOrder), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.view.backgroundColor = .systemBackground
        viewModel.viewDidLoad()
        
    }
   
    @objc func buyOrder(){
        viewModel.buyOrder()
    }

}
extension PurchaseViewController : IPurchaseViewController {
    func goHomeView(){
        self.tabBarController?.selectedIndex = 0
    }
    func updateTableView(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("addedToFirestor"), object: nil, queue: nil) { [weak self]_ in
            guard let self = self else {
                return
            }
            viewModel.getOrders()
        }
    }
    func tableViewReload() {
        DispatchQueue.main.async {
            self.bookTableView.reloadData()
        }
    }
    
    func prepareTableView() {
        self.bookTableView.delegate = self
        self.bookTableView.dataSource = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.bookTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.bookTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.bookTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.bookTableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9),
            
            self.buyButton.topAnchor.constraint(equalTo: self.bookTableView.bottomAnchor, constant: 20),
            self.buyButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            self.buyButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
  
        ])
    }
    
    func presentAlert(title : String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        
        DispatchQueue.main.async{self.present(alert, animated: true)}
    }
    
    func setUpNavigationController() {
        self.navigationItem.title = "Purchase"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func viewAddSubviews() {
        view.addSubview(self.bookTableView)
        view.addSubview(self.buyButton)
    }
    
}

extension PurchaseViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookTableView.dequeueReusableCell(withIdentifier: BookTableViewCell.id, for: indexPath) as? BookTableViewCell else{
            return UITableViewCell()
        }
        let cellViewModels = viewModel.getCellViewModels()
        cell.configure(viewModel: cellViewModels[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        225
    }

    
    
}
