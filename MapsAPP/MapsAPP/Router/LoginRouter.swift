//
//  LoginRouter.swift
//  MapsAPP
//
//  Created by User on 29.04.2021.
//

import UIKit

final class LoginRouter: BaseRouter {
    func toMain() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MainController.self)
        setAsRoot(UINavigationController(rootViewController: controller))
    }

    func onRecover() {
        let controller = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(RecoveryPasswordController.self)
        show(controller)
    }
}
