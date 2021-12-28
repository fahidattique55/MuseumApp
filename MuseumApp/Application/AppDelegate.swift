//
//  AppDelegate.swift
//  MuseumApp
//
//  Created by fahid on 20/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureApp()
        return true
    }
}

extension AppDelegate {
    private func configureApp() {
        let appCoordinator = AppCoordinator(with: nil)
        appCoordinator.performTransition(.searchObject)
    }
}
