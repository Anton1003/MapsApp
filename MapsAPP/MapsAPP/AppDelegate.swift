//
//  AppDelegate.swift
//  MapsAPP
//
//  Created by User on 26.04.2021.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyC1uJ_iiqD-y9c9fwcT7_qsDRiQqhYLntM")
        return true
    }
    
}

