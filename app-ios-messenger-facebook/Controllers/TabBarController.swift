//
//  TabBarController.swift
//  app-ios-messenger-facebook
//
//  Created by ODDS on 26/2/2563 BE.
//  Copyright © 2563 ODDS. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        let friendController = FriendsController(collectionViewLayout: layout)
        let recentMessageNavigationControlller = UINavigationController(rootViewController: friendController)
        recentMessageNavigationControlller.tabBarItem.title = "Recent"
        recentMessageNavigationControlller.tabBarItem.image = UIImage(named: "recent")
        
        let callsController = createDummyNavigationControllerWithTitle(title: "Calls", imageName: "calls")
        
        viewControllers = [recentMessageNavigationControlller, callsController]
    }
    
    private func createDummyNavigationControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }

}
