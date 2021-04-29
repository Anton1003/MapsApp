//
//  RecoveryPasswordController.swift
//  MapsAPP
//
//  Created by User on 29.04.2021.
//

import UIKit
///
final class RecoveryPasswordController: UIViewController {
    @IBOutlet var loginTextField: UITextField!

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
              login == LoginController.Constants.login
        else { return }

        showPassword()
    }
}
