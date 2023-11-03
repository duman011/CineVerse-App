//
//  MainTabBarViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Tab bar arka plan rengini beyaz yapın
        UITabBar.appearance().backgroundColor = .clear

          // Seçili olan öğelerin rengini turuncu yapın
        UITabBar.appearance().tintColor = MovieColor.playButonBG
       
          // Seçilmeyen öğelerin rengini gri yapın
        UITabBar.appearance().unselectedItemTintColor = .systemGray
        
        viewControllers = [
            createHomeNC(),
            createSearchNC(),
            createFavoritesNC(),
            createProfileNC()
        ]
    }
    
    
    // MARK: - Home Navigation Controller 🏠
    func createHomeNC() -> UINavigationController {
        let homeVC        = HomeViewController()

        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(systemName: "house"),
                                         tag: 0)
        
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        return UINavigationController(rootViewController: homeVC)
    }
 
    // MARK: - Search Navigation Controller 🔍
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchViewController()
        searchVC.title      = "Discover"
       
        searchVC.tabBarItem = UITabBarItem(title: "Search",
                                           image: UIImage(systemName: "magnifyingglass"),
                                           tag: 1)
        
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    // MARK: - Favorites Navigation Controller ⭐️
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC        = DownloadsViewController()
        
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites",
                                           image: UIImage(systemName: "arrow.down.to.line"),
                                           tag: 2)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
//     MARK: - Profile Navigation Controller ⚙️
        func createProfileNC() -> UINavigationController {
            let profileVC        = ProfileViewController()
    
            profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                               image: UIImage(systemName: "person"),
                                               tag: 3)
    
            return UINavigationController(rootViewController: profileVC)
        }
}
