//
//  MainController.swift
//  MapsAPP
//
//  Created by User on 29.04.2021.
//

import UIKit

final class MainController: UIViewController {
    private var router = MainRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        router.controller = self
    }

    @IBAction func showMap(_ sender: Any) {
        router.toMap()
    }

    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        router.toLaunch()
    }
}
