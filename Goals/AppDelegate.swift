//
//  AppDelegate.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 22/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let appDependencies = GoalsAppDependencyContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let mainVC = appDependencies.makeMainViewController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainVC

        return true
    }
}

