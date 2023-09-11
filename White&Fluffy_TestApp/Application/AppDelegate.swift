//
//  AppDelegate.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 06.09.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = StartTabBarController()
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.overrideUserInterfaceStyle = .light
        
        return true
    }
}

