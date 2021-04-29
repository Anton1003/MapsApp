//
//  LoginController.swift
//  MapsAPP
//
//  Created by User on 29.04.2021.
//

import RealmSwift
import UIKit

final class LoginController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    private let loginRouter = LoginRouter()
    private let realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginRouter.controller = self
    }

    private func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func login(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        if let user = realm?.object(ofType: User.self, forPrimaryKey: login) {
            if user.password == password {
                UserDefaults.standard.set(true, forKey: "isLogin")
                loginRouter.toMain()
                print("Login")
            } else {
                showAlert(title: "Неправильный пароль")
            }
        } else {
            showAlert(title: "Нет такого пользователя")
        }
    }

    @IBAction func recovery(_ sender: Any) {
        loginRouter.onRecover()
    }
}
