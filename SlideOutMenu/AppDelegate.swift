//
//  AppDelegate.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func setupAppearance() {
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = .white
            let navigationBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationBarAppearance.backgroundColor = .systemGray5
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            }
        }
    }

}

