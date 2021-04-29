//
//  User.swift
//  MapsAPP
//
//  Created by User on 30.04.2021.
//

import Foundation
import RealmSwift

final class User: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""

    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }

    override class func primaryKey() -> String? {
        "login"
    }
}
