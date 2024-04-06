//
//  AuthManager.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 29.03.2024.
//

import Foundation
import FirebaseAuth


protocol IAuthManager{
    func logIn(mail : String , password : String , completion : @escaping (Result<Void , Error>)->Void)
    func createUser(mail : String , password : String , completion : @escaping (Result<Void , Error>)-> Void)
    func logOut()
}
class AuthManager : IAuthManager{
    func logIn(mail : String , password : String , completion : @escaping (Result<Void , Error>)->Void){
        Auth.auth().signIn(withEmail: mail, password: password) { _, err in
            if err != nil{
                completion(.failure(err!))
            }else{
                completion(.success(()))
            }
        }
    }
    func createUser(mail : String , password : String , completion : @escaping (Result<Void , Error>)-> Void){
        Auth.auth().createUser(withEmail: mail, password: password) { _, err in
            if err != nil{
                completion(.failure(err!))
            }else{
                completion(.success(()))
            }
        }
    }
    func logOut(){
        do{
            try Auth.auth().signOut()
        }catch{
        }
    }
    
}
