//
//  ViewController.swift
//  InRoad
//
//  Created by Dinmukhamed on 18.02.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
        
        view.backgroundColor = .white
    }
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: HomeViewController(),
                       title: "Карта",
                       image: UIImage(named: "Map")),
            
            generateVC(viewController: UnavailableViewController(),
                       title: "Настройки",
                       image: UIImage(named: "Settings"))
        ]
    }
    
        private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
            viewController.tabBarItem.title = title
            viewController.tabBarItem.image = image
            let navController = UINavigationController(rootViewController: viewController)
            return navController
        }
    
    private func setTabBarAppearance() {
        tabBar.tintColor = .mainBlue
        tabBar.backgroundColor = .white
    }
    
}

