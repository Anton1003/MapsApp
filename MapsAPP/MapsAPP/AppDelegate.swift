//
//  AppDelegate.swift
//  MapsAPP
//
//  Created by User on 26.04.2021.
//

import GoogleMaps
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyC1uJ_iiqD-y9c9fwcT7_qsDRiQqhYLntM")

        let controller: UIViewController
        if UserDefaults.standard.bool(forKey: "isLogin") {
            controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MainController.self)
        } else {
            controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(LoginController.self)
        }
        window = UIWindow()

        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        return true
    }
}
