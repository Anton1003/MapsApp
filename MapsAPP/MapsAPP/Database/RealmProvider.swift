//
//  RealmProvider.swift
//  MapsAPP
//
//  Created by User on 28.04.2021.
//

import Foundation
import RealmSwift

final class RealmProvider {
    static let deleteIfMifration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    static func save<T: Object>(
        items: [T],
        config: Realm.Configuration = deleteIfMifration,
        update: Realm.UpdatePolicy = .all
    ) {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(items, update: update)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    static func saveOne<T: Object>(
        item: T,
        config: Realm.Configuration = deleteIfMifration,
        update: Realm.UpdatePolicy = .all
    ) {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(item, update: update)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    static func get<T: Object>(type: T.Type, config: Realm.Configuration = deleteIfMifration) -> Results<T> {
        guard let realm = try? Realm(configuration: config) else { preconditionFailure() }
        return realm.objects(type)
    }

    static func delete<T: Object>(type: T.Type, config: Realm.Configuration = deleteIfMifration) {
        do {
            let realm = try Realm(configuration: config)
            let object = realm.objects(type)

            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    static func delete<T: Object>(_ items: [T], config: Realm.Configuration = deleteIfMifration) {
        let realm = try? Realm(configuration: config)
        try? realm?.write {
            realm?.delete(items)
        }
    }
}
