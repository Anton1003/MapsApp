//
//  SelfyController.swift
//  MapsAPP
//
//  Created by User on 02.05.2021.
//

import UIKit
///
class SelfyController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
    }
}
