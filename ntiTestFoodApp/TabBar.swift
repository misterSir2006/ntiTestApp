//
//  TabBar.swift
//  ntiTestFoodApp
//
//  Created by Илья Шахназаров on 08.07.2022.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .black
        tabBar.tintColor = .yellow
        tabBar.unselectedItemTintColor = .white
        setupVCs()
    }

    func setupVCs() {
        viewControllers = [
            createNavController(for: ShopViewController(), image: UIImage(systemName: "list.bullet")!),
            createNavController(for: EmptyVC(), image: UIImage(systemName: "bag")!),
            createNavController(for: AnotherEmptyVC(), image: UIImage(systemName: "info")!)
        ]
    }

    fileprivate func createNavController(for rootViewController: UIViewController, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        return navController
    }
}

class EmptyVC: UIViewController {
    
}

class AnotherEmptyVC: UIViewController {
    
}
