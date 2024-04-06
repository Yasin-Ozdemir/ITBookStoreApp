//
//  BookTableViewCell.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 2.04.2024.
//

import Foundation
import SDWebImage
import UIKit
class BookTableViewCell : UITableViewCell{
     static let id = "booktableviewcell"
    private let bookImageView : UIImageView = {
       let imageview = UIImageView()
      
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    private let nameLabel : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let priceLabel : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let removeButton : UIButton = {
        let button = UIButton(type: .system)
      
        button.setImage(UIImage(systemName: "minus.circle"), for: UIControl.State.normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    func setupConstraints(){
        NSLayoutConstraint.activate([
        
            
            bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -35),
            bookImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bookImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.55),
            bookImageView.topAnchor.constraint(equalTo: topAnchor),
            
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -5),
            removeButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            removeButton.widthAnchor.constraint(equalToConstant: 40),
            removeButton.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: -30),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor ,constant: -5),
            
            priceLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: -30),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor ,constant: 1),
            
            
            
        
        ])
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bookImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(removeButton)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func configure(viewModel : BookTableCellViewModel){
        self.bookImageView.sd_setImage(with: URL(string: viewModel.imageUrl))
        self.nameLabel.text = viewModel.bookName
        self.priceLabel.text = viewModel.price
        print("configured")
    }
    
}
