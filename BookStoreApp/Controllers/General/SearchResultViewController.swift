//
//  SearchResultViewController.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 31.03.2024.
//

import UIKit

class SearchResultViewController: UIViewController {
    weak var delegate : IHomeViewController?
    var manager : INetworkManager!
     let bookCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: 185, height: 250)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var bookCellViewModels : [BookCellViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupCollectionView()
        view.addSubview(bookCollectionView)
    }
    override func viewDidLayoutSubviews() {
        self.bookCollectionView.frame = view.bounds
    }
}

extension SearchResultViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func setupCollectionView(){
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        bookCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as? BookCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(with: bookCellViewModels[indexPath.row])
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.goDetailVC(isbn: bookCellViewModels[indexPath.row].isbn)
    }

    
}
