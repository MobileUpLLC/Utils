//
//  AppDelegate.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = UINavigationController(rootViewController: ExampleViewController())

        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        return true
    }
}
