//
//  AppDelegate.swift
//  NYTimesMostPopular
//
//  Created by Enrique Aliaga on 17/02/24.
//

import UIKit
import NYTimesiOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let injectionContainer = NYTimesAppDependencyContainer()
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let mainVC = injectionContainer.makeMainViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainVC
        
        return true
    }
}
