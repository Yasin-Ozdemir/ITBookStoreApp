//
//  BookModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 30.03.2024.
//

import Foundation

// MARK: - BookModel
struct BookModel: Codable {
    let error, total: String
    let books: [Book]
}

// MARK: - Book
struct Book: Codable {
    let title, subtitle, isbn13, price: String
    let image: String
    let url: String
}
