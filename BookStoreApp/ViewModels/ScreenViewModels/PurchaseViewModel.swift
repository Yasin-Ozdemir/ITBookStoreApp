//
//  PurchaseViewModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 2.04.2024.
//

import Foundation
protocol IPurchaseViewModel{
    func numberOfRowsInSection() -> Int
    func viewDidLoad()
    func getCellViewModels() -> [BookTableCellViewModel]
    var delegate : IPurchaseViewController? {get set}
    func getOrders()
    func buyOrder()
    
}
class PurchaseViewModel : IPurchaseViewModel{
   
    
  
    
    private var books : [BookTableCellViewModel] = []
    weak var delegate: IPurchaseViewController?
    private var fireStoreManager : IFirestoreManager!
    init(fireStoreManager: IFirestoreManager!) {
        self.fireStoreManager = fireStoreManager
    }
    func getOrders(){
        
        fireStoreManager.getOrderToFirestore { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let orders) :
                books.removeAll()
                for order in orders {
                    books.append(BookTableCellViewModel(bookName: order.bookName, imageUrl: order.imageUrl, price: order.price, id: order.id))
                }
                delegate?.tableViewReload()
            case . failure(let err) : delegate?.presentAlert(title: "ERROR", message: err.localizedDescription)
            }
        }
    }
    
   
    func viewDidLoad() {
        delegate?.prepareTableView()
        delegate?.setUpNavigationController()
        delegate?.viewAddSubviews()
        delegate?.setupConstraints()
        getOrders()
        delegate?.updateTableView()
    }
    func buyOrder() {
        for book in books{
            fireStoreManager.deleteOrder(id: book.id.uuidString) { [weak self]result in
                guard let self = self else{
                    return
                }
                switch result{
                case .success(_) : delegate?.presentAlert(title: "SUCCESS", message: "Purchased")
                    
                case . failure(_) : delegate?.presentAlert(title: "ERROR", message: "No Purchased")
                }
            }
        }
        books.removeAll()
        delegate?.tableViewReload()
    }
    func numberOfRowsInSection() -> Int {
        return books.count
    }
    func getCellViewModels() -> [BookTableCellViewModel]{
        return self.books
    }
  
   
   
}
