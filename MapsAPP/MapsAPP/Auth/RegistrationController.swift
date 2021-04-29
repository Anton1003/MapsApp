//
//  RecoveryPasswordController.swift
//  MapsAPP
//
//  Created by User on 29.04.2021.
//

import UIKit
///
final class RegistrationController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    private var loginRouter = LoginRouter()
    private var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func showPassword() {
        let alertController = UIAlertController(title: "Пароль", message: "123456", preferredStyle: .alert)
        let okAcion = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAcion)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func recovery(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        user.login = login
        user.password = password
        RealmProvider.saveOne(item: user)
        loginRouter.toMain()
    }
}
