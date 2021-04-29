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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == Constants.login, password == Constants.password
        else { return }

        print("Login")
    }

    @IBAction func recovery(_ sender: Any) {}
}
