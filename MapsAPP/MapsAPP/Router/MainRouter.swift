//
//  MainRouter.swift
//  MapsAPP
//
//  Created by User on 29.04.2021.
//

import UIKit

final class MainRouter: BaseRouter {
    func toMap() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MapViewController.self)
        show(controller)
    }

    func toLaunch() {
        let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(LoginController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }
    
//    func showSelfyModule(image: UIImage) {
//        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(SelfyController.self)
//        controller.image = image
//        rootCon
//    }
}
