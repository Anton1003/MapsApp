//
//  LoginController.swift
//  MapsAPP
//
//  Created by User on 29.04.2021.
//

import UIKit

final class LoginController: UIViewController {
    enum Constants {
        static let login = "admin"
        static let password = "123456"
    }

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    private let loginRouter = LoginRouter()

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        if UserDefaults.standard.bool(forKey: "isLogin") {
//            performSegue(withIdentifier: "toMain", sender: self)
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginRouter.controller = self
    }

    @IBAction func login(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == Constants.login, password == Constants.password
        else { return }

        UserDefaults.standard.set(true, forKey: "isLogin")
        loginRouter.toMain()

        print("Login")
    }

    @IBAction func recovery(_ sender: Any) {
        loginRouter.onRecover()
    }
}
