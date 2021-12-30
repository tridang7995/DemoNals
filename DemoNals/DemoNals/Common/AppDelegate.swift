//
//  AppDelegate.swift
//  DemoNals
//
//  Created by Tri Dang on 29/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configRootView()
        Thread.sleep(forTimeInterval: 2)
        return true
    }
    
    private func configRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: ListViewController(ListViewModel()))
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
