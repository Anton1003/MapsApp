//
//  LocationManager.swift
//  MapsAPP
//
//  Created by User on 01.05.2021.
//

import CoreLocation
import RxCocoa
import RxSwift
import UIKit

final class LocationManager: NSObject {
    static let instance = LocationManager()
    var location: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    let locationManager = CLLocationManager()

    override private init() {
        super.init()
        configure()
    }

    func configure() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestWhenInUseAuthorization()
    }

    func startLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location.accept(locations.last)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
