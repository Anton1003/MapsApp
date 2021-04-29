//
//  Location.swift
//  MapsAPP
//
//  Created by User on 28.04.2021.
//

import Foundation
import RealmSwift

final class Location: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longtitude = 0.0
}
