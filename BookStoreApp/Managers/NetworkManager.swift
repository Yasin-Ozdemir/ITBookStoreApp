//
//  NetworkManager.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 30.03.2024.
//

import Foundation

enum NetworkError : Error{
    case serverError
    case parseError
    case connectError
}
protocol INetworkManager {
    func downloadBooks(completion : @escaping (Result<[Book] ,Error>)-> Void)
    func searchBook(with bookName : String , completion : @escaping (Result<[Book] ,Error>)-> Void)
}
class NetworkManager : INetworkManager{
    private let baseUrlString = "https://api.itbook.store/1.0/"
    
    func downloadBooks(completion : @escaping (Result<[Book] ,Error>)-> Void) {
        
        guard let url = URL(string: "\(baseUrlString)new") else{
            return
        }
        let request = URLRequest(url: url)
            
        URLSession.shared.dataTask(with: request) { data, response, err in
            if err != nil{
                completion(.failure(NetworkError.serverError))
            }else{
                guard let data = data , let response = response else{
                    completion(.failure(NetworkError.connectError))
                    return
                }
                
                do{
                    let result =  try JSONDecoder().decode(BookModel.self, from: data)
                    completion(.success(result.books))
                }catch{
                    completion(.failure(NetworkError.parseError))
                }
            }
            
        }.resume()
    }
    
    func searchBook(with bookName : String , completion : @escaping (Result<[Book] ,Error>)-> Void){
        guard let url = URL(string: "\(baseUrlString)search/\(bookName)") else{
            return
        }
        let request = URLRequest(url: url)
            
        URLSession.shared.dataTask(with: request) { data, response, err in
            if err != nil{
                completion(.failure(NetworkError.serverError))
            }else{
                guard let data = data , let response = response else{
                    completion(.failure(NetworkError.connectError))
                    return
                }
                
                do{
                    let result =  try JSONDecoder().decode(BookModel.self, from: data)
                    completion(.success(result.books))
                }catch{
                    completion(.failure(NetworkError.parseError))
                }
            }
            
        }.resume()
        
    }
    
    func downloadBookDetail(with isbn : String ,completion : @escaping (Result<BookDetailModel ,Error>)-> Void ){
        guard let url = URL(string: "\(baseUrlString)books/\(isbn)") else{
            return
        }
        let request = URLRequest(url: url)
            
        URLSession.shared.dataTask(with: request) { data, response, err in
            if err != nil{
                completion(.failure(NetworkError.serverError))
            }else{
                guard let data = data , let response = response else{
                    completion(.failure(NetworkError.connectError))
                    return
                }
                
                do{
                    let result =  try JSONDecoder().decode(BookDetailModel.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(NetworkError.parseError))
                }
            }
            
        }.resume()
    }
}
