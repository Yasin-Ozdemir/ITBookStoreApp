//
//  BookCollectionViewCell.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 30.03.2024.
//

import Foundation
import UIKit
import SDWebImage
class BookCollectionViewCell : UICollectionViewCell{
    
    static let id = "bookcollection"
    private let bookImage : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    func setupConstraints(){
        NSLayoutConstraint.activate([
        
           priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -2),
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
           
            titleLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -1),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
           bookImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
           bookImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
           bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 15),
            
        ])
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemFill
        addSubview(bookImage)
        addSubview(titleLabel)
        addSubview(priceLabel)
       setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewmodel : BookCellViewModel){
       
        bookImage.sd_setImage(with: URL(string: viewmodel.imageUrl))
        titleLabel.text = viewmodel.name
        priceLabel.text = viewmodel.price
    }
    
}
