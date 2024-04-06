//
//  HomeViewModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 30.03.2024.
//

import Foundation

protocol IHomeViewModel{
    func viewDidLoad()
    func getBooks()
    func searchBooks(with bookName : String)
    func numberOfItemsInSection()-> Int
    var delegate : IHomeViewController? {get set}
    func getbookCellViewModels() -> [BookCellViewModel]
    func getSearchedBooks() -> [BookCellViewModel]
    func goDetailVC(index : Int)
}
class HomeViewModel : IHomeViewModel{
    
    
    private var bookCellViewModels : [BookCellViewModel] = []
    private var searchedBooks : [BookCellViewModel] = []
    weak var delegate : IHomeViewController?
    var manager : INetworkManager?
    init( manager: INetworkManager? = nil) {
        self.manager = manager
    }
    func numberOfItemsInSection()->Int  {
        return bookCellViewModels.count
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.setupConstraints()
        delegate?.setUpNavigationController()
        delegate?.prapereSearchController()
        getBooks()
    }
        func getBooks() {
        manager?.downloadBooks(completion: {[weak self] result in
            guard let self = self else{
                return
            }
            switch result{
            case .success(let books) :
                for book in books{
                    bookCellViewModels.append(BookCellViewModel(name: book.title, imageUrl: book.image, price: book.price, subtitle: book.subtitle, isbn: book.isbn13))
                    delegate?.reloadCollectionView()
                }
            case .failure(let err) :
                delegate?.presentAlert(message: err.localizedDescription)
            }
        })
    }
    func goDetailVC(index : Int) {
        delegate?.goDetailVC(isbn: bookCellViewModels[index].isbn)
    }
    func getbookCellViewModels() -> [BookCellViewModel]{
        return bookCellViewModels
    }
    func getSearchedBooks() -> [BookCellViewModel] {
        return searchedBooks
    }
    
    func searchBooks(with bookName : String) {
        manager?.searchBook(with: bookName, completion: { [weak self]result in
            guard let self = self else{
                return
            }
            switch result {
            case.success(let books) :
                searchedBooks.removeAll()
                for book in books{
                    searchedBooks.append(BookCellViewModel(name: book.title, imageUrl: book.image, price: book.price, subtitle: book.subtitle, isbn: book.isbn13))
                    print(book.title)
                }
            case .failure(let err) : delegate?.presentAlert(message: err.localizedDescription)
                
            }
        })
    }
    
    
    
    
}
