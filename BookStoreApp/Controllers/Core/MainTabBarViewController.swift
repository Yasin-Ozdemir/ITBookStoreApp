//
//  MainTabBarViewController.swift
//  BookStoreApp
//
//  Created by Yasin Özdemir on 28.03.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let homeViewController = UINavigationController(rootViewController: HomeViewController())
    let purchaseViewController = UINavigationController(rootViewController: PurchaseViewController())
    let userViewController = UINavigationController(rootViewController: UserViewController())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setTitles()
        setImages()
        self.navigationItem.hidesBackButton = true

    }
    
    func setupTabBar(){
        setViewControllers([homeViewController , purchaseViewController , userViewController], animated: true)
        tabBar.tintColor = .label
    }
    
    func setTitles(){
        homeViewController.tabBarItem.title = "Home"
        purchaseViewController.tabBarItem.title = "Purchase"
        userViewController.tabBarItem.title = "User"
    }
    
    func setImages(){
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        purchaseViewController.tabBarItem.image = UIImage(systemName: "basket")
        userViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
    }
    
    
    

}
