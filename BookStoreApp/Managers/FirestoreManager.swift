//
//  FirestoreManager.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 3.04.2024.
//

import Foundation
import Firebase
protocol IFirestoreManager{
    func setOrderToFirestore(order : Order)
    func getOrderToFirestore(completion : @escaping (Result<[Order] , Error>)-> Void)
    func deleteOrder(id : String , completion : @escaping (Result<Void , Error>)-> Void)
    
}

class FirestoreManager :IFirestoreManager{
    let db = Firestore.firestore()
    func setOrderToFirestore(order : Order){
        
        let orderJson : [String : Any] = [
            "bookName" : order.bookName,
            "imageUrl" : order.imageUrl,
            "price" : order.price,
            
        ]
        
        db.collection("orders").document(order.id.uuidString).setData(orderJson)
    }
    
    func getOrderToFirestore(completion : @escaping (Result<[Order] , Error>)-> Void){
            db.collection("orders").getDocuments { querySnapshot, err in
            if err != nil{
                completion(.failure(err!))
            }else{
                guard let querySnapshot = querySnapshot else{
                    return
                }
                var orders : [Order] = []
                for document in querySnapshot.documents {
                    let data = document.data() // json alındı
                    let docID = UUID(uuidString: document.documentID)
                    
                    guard let name = data["bookName"] as? String , let imageUrl = data ["imageUrl"] as? String , let price = data["price"] as? String else {
                        return
                    }
                    orders.append(Order(bookName: name, imageUrl: imageUrl, price: price, id:  docID! ))
                    
                }
                completion(.success(orders))
            }
        }
    }
    
    func deleteOrder(id : String , completion : @escaping (Result<Void , Error>)-> Void) {
        db.collection("orders").document(id).delete { err in
            if err != nil{
                completion(.failure(err!))
            }else{
                completion(.success(()))
            }
        }
    }
    
  
}
