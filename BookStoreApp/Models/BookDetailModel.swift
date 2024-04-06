//
//  BookDetailModel.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 1.04.2024.
//

import Foundation

struct BookDetailModel: Codable {
        let error, title, subtitle, authors: String
        let publisher, language, isbn10, isbn13: String
        let pages, year, rating, desc: String
        let price: String
        let image: String
        let url: String
}

