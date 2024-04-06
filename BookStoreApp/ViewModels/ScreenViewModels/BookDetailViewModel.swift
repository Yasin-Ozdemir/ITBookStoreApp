//
//  BookDetailViewModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 1.04.2024.
//

import Foundation
protocol IBookDetailViewModel{
    var isbn : String! {get set}
    func getBookDetail()
    func viewDidLoad()
    func addBookToBasket(bookName : String , imageUrl : String , price : String)
    var delegate : IBookDetailViewController? { get set}
}
class BookDetailViewModel : IBookDetailViewModel{
    var isbn : String!
    weak var delegate : IBookDetailViewController?
    let manager : NetworkManager!
    let firestoreManager : IFirestoreManager!
    init(isbn: String!,  manager: NetworkManager!, firestoreManager : IFirestoreManager!) {
        self.isbn = isbn
        self.manager = manager
        self.firestoreManager = firestoreManager
    }
    func addBookToBasket(bookName : String , imageUrl : String , price : String){
        firestoreManager.setOrderToFirestore(order: Order(bookName: bookName, imageUrl: imageUrl, price: price, id: UUID()))
        delegate?.presentAlert(message: "Added To Cart")
    }
    func getBookDetail(){
        manager.downloadBookDetail(with: isbn) { [weak self]result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let bookDetail) : delegate?.configure(with: bookDetail)
            case .failure(let err) : delegate?.presentAlert(message: err.localizedDescription)
            }
        }
    }
    func viewDidLoad(){
        delegate?.setUpNavigationController()
        delegate?.viewAddSubviews()
        delegate?.setupConstraint()
        getBookDetail()
    }
}
