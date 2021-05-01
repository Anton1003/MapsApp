//
//  LoginController.swift
//  MapsAPP
//
//  Created by User on 29.04.2021.
//

import RealmSwift
import RxCocoa
import RxSwift
import UIKit

final class LoginController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!

    private let loginRouter = LoginRouter()
    private let realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginRouter.controller = self
        bindViewModel()
    }

    private func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    private func bindViewModel() {
        Observable
            .combineLatest(loginTextField.rx.text, passwordTextField.rx.text).map { login, password in
                !(login ?? "").isEmpty && !(password ?? "").isEmpty
            }.bind { [weak logInButton] input in
                logInButton?.isEnabled = input
            }
    }

    @IBAction func login(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        if let user = realm?.object(ofType: User.self, forPrimaryKey: login) {
            if user.password == password {
                UserDefaults.standard.set(true, forKey: "isLogin")
                loginRouter.toMain()
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
