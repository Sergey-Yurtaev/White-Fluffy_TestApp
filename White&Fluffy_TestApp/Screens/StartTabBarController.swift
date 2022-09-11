//
//  StartTabBarController.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 06.09.2022.
//

import UIKit

class StartTabBarController: UITabBarController {
    
    private let navBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() { 
        viewControllers = [
            createNavController(viewController: MainPhotoViewController(), title: "", imageName: #imageLiteral(resourceName: "search")),
            createNavController(viewController: FavoriteViewController(), title: "Favorite photos", imageName: #imageLiteral(resourceName: "favorite"))
        ]
        
        self.viewControllers?.forEach{ controller in
            controller.tabBarItem.selectedImage = #imageLiteral(resourceName: "circle")
        }
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = false
        viewController.navigationItem.title = title
        navController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = imageName
        return navController
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        tabBar.tintColor = UIColor.blueCustom
        tabBar.unselectedItemTintColor = UIColor.blueCustom
    }
}


