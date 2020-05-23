//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Nikolai Prokofev on 2020-05-19.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchController(), createFavoritesController()]
    }
    
    private func createSearchController()-> UINavigationController {
        
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let navigationController = UINavigationController(rootViewController: searchVC)
        return navigationController
    }

    private func createFavoritesController()-> UINavigationController {
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let navigationController = UINavigationController(rootViewController: favoritesVC)
        return navigationController
    }
}
