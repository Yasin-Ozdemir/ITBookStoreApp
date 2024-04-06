//
//  HomeViewController.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 29.03.2024.
//

import UIKit
protocol IHomeViewController : AnyObject{
   
    func presentAlert(message : String)
    func reloadCollectionView()
    func setUpNavigationController()
    func prepareCollectionView()
    func setupConstraints()
    func prapereSearchController()
    func goDetailVC(isbn : String)
}
class HomeViewController: UIViewController {
    let manager = NetworkManager()
    var viewModel : IHomeViewModel!
    private let collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: 185, height: 250)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let searchController : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Enter The Book Name"
        return controller
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        viewModel = HomeViewModel(manager: self.manager)
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
}



extension HomeViewController : IHomeViewController{
    func setupConstraints(){
        NSLayoutConstraint.activate([
        
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func presentAlert(message : String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        
        DispatchQueue.main.async{self.present(alert, animated: true)}
    }
    func prepareCollectionView(){
        view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    func setUpNavigationController(){
        self.navigationItem.title = "New Books"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.searchController = searchController
    }
    
    func prapereSearchController(){
        self.searchController.searchResultsUpdater = self
        
    }
    func goDetailVC(isbn : String){
        let bookDetailViewModel = BookDetailViewModel(isbn: isbn ,  manager: self.manager , firestoreManager: FirestoreManager())
        let vc = BookDetailViewController()
        vc.viewModel = bookDetailViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as? BookCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.getbookCellViewModels()[indexPath.row])
        cell.layer.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.goDetailVC(index : indexPath.row)
    }
    
}


extension HomeViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let bookname = searchController.searchBar.text , bookname.trimmingCharacters(in: .whitespaces).isEmpty == false , 
        bookname.trimmingCharacters(in: .whitespaces).count > 2 ,  let resultController = searchController.searchResultsController as? SearchResultViewController else{
            return
        }
        viewModel.searchBooks(with: bookname)
        resultController.bookCellViewModels = viewModel.getSearchedBooks()
        resultController.manager = self.manager
        resultController.delegate = self
        DispatchQueue.main.async {
            resultController.bookCollectionView.reloadData()
        }
    }
    
    
}
