//
//  MainTabBarViewController.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 03.04.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([createNavController(for: MenuViewController(),
                                                title: "Меню", image: UIImage(named: "Menu")),
                           createNavController(for: ContactsViewController(),
                                               title: "Контаты", image: UIImage(named: "Contacts")),
                            createNavController(for: ProfileViewController(),
                                                title: "Пофиль", image: UIImage(named: "Profile")),
                            createNavController(for: BasketViewController(), title: "Корзина", image: UIImage(named: "Basket"))], animated: false)
        tabBar.tintColor = .red
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
