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

//    @IBAction func takePicture(_ sender: Any) {
//        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.allowsEditing = true
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true)
//    }
}

// extension MainController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true)
//    }
//
//    func imagePickerController(
//        _ picker: UIImagePickerController,
//        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
//    ) {
//        picker.dismiss(animated: true) { [weak self] in
//            guard let image = self?.extractImage(from: info) else {return}
//            self?.onTakePicture?(image)
//        }    }
//
//    private func extractImage(from info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
//        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            return image
//        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            return image
//        } else {
//            return nil
//        }
//    }
// }
