//
//  BookDetailViewController.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 31.03.2024.
//

import UIKit
protocol IBookDetailViewController : AnyObject{
    func setupConstraint()
    func configure(with model : BookDetailModel)
    func presentAlert(message : String)
    func setUpNavigationController()
    func viewAddSubviews()
}
class BookDetailViewController: UIViewController {
    var viewModel : IBookDetailViewModel!
   
    private let bookImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode  = .scaleToFill
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let bookNameLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
         label.numberOfLines = 1
         label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
         label.textColor = .label
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let descLabel : UITextView = {
        let txtView = UITextView()
         txtView.isScrollEnabled = false
         txtView.isEditable = false
         txtView.font = .systemFont(ofSize: 15)
        txtView.translatesAutoresizingMaskIntoConstraints = false
         return txtView
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let bookInfoTextView : UITextView = {
       let txtView = UITextView()
        txtView.isScrollEnabled = false
        txtView.isEditable = false
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.textAlignment = .center
        txtView.font = .boldSystemFont(ofSize: 13)
        return txtView
    }()
    
    private let addBasket : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add To Cart", for: UIControl.State.normal)
        button.backgroundColor = .secondaryLabel
        button.setTitleColor(.label, for: UIControl.State.normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addBookToBasket), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        viewModel.delegate = self
        viewModel.viewDidLoad()

    }
    var imageUrl = ""
    @objc func addBookToBasket(){
        guard let bookName = bookNameLabel.text , let price = priceLabel.text else{
            return
        }
        viewModel.addBookToBasket(bookName: bookName, imageUrl: imageUrl, price: price)
        NotificationCenter.default.post(name: NSNotification.Name("addedToFirestor"), object: nil)
    }

}

extension BookDetailViewController : IBookDetailViewController {
    func viewAddSubviews(){
        view.addSubview(bookImageView)
        view.addSubview(bookNameLabel)
      //view.addSubview(subTitleLabel)
        view.addSubview(priceLabel)
        view.addSubview(descLabel)
        view.addSubview(bookInfoTextView)
        view.addSubview(addBasket)
    }
    func configure(with model : BookDetailModel) {
        DispatchQueue.main.async {
            self.navigationItem.title = model.title
            self.imageUrl = model.image
            self.bookImageView.sd_setImage(with: URL(string: model.image))
            self.bookNameLabel.text = model.title
            self.subTitleLabel.text = model.subtitle
            self.priceLabel.text = model.price
            self.descLabel.text = model.desc
            self.bookInfoTextView.text = " Authors : \(model.authors) \n Publisher : \(model.publisher) \n Pages : \(model.pages) \n Rating : \(model.rating) \n Language : \(model.language) "
        }
      
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            self.bookImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.bookImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -35),
            self.bookImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            self.bookImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
            
            self.bookNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 7),
            self.bookNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            self.bookNameLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: -40),
            
          /*  self.subTitleLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 10),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: -40),*/
            
            self.priceLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 10),
            self.priceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            self.priceLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: -40),
           
            self.descLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10),
            self.descLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 2),
            self.descLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant: -2),
            
            self.bookInfoTextView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            self.bookInfoTextView.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor , constant: -40),
            self.bookInfoTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant: -5),
            
           self.addBasket.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10),
            self.addBasket.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.addBasket.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            self.addBasket.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10)
        ])
    }
    func presentAlert(message : String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        
        DispatchQueue.main.async{self.present(alert, animated: true)}
    }
    func setUpNavigationController(){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .label
    }
    
}
