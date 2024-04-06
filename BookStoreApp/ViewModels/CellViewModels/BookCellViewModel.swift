//
//  BookCellViewModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 30.03.2024.
//

import Foundation

struct BookCellViewModel{
    
    let name : String!
    let imageUrl : String!
    let price : String!
    let subtitle : String!
    let isbn : String!
    init(name: String!, imageUrl: String!, price: String!, subtitle: String!, isbn: String!) {
        self.name = name
        self.imageUrl = imageUrl
        self.price = price
        self.subtitle = subtitle
        self.isbn = isbn
    }
    
}
