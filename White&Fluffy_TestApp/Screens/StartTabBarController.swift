//
//  StartTabBarController.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 06.09.2022.
//

import UIKit

final class StartTabBarController: UITabBarController {
   
    private let navBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarAppearance()
        generateTabBar()
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
        navController.view.backgroundColor = .whiteCustom
        navController.tabBarItem.image = imageName
        return navController
    }
    
    private func setTabBarAppearance() {
        
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .whiteCustom
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.red]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.blueCustom
            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.blueCustom
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
    }
}


