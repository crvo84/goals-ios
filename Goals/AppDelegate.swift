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

    let appDependencyContainer = GoalsAppDependencyContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = appDependencyContainer.makeMainViewController()

        return true
    }
}

