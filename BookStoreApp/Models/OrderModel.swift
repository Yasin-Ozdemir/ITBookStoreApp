//
//  OrderModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 3.04.2024.
//

import Foundation

struct Order {
   let bookName : String
    let imageUrl : String
    let price : String
    let id : UUID
    
    init(bookName: String, imageUrl: String, price: String  , id : UUID) {
        self.bookName = bookName
        self.imageUrl = imageUrl
        self.price = price
        self.id = id
    }
}
