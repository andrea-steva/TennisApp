//
//  LocationManager.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate: class {

    func locationManagerDidUpdateLocation(_ localizationManager: LocationManager)
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    // MARK: Property

    fileprivate let manager = CLLocationManager()
    fileprivate static let geocoder = CLGeocoder()

    fileprivate var isMonitoring = false

    fileprivate var lastLocation: CLLocation?
    fileprivate var placemark: CLPlacemark?

    fileprivate weak var delegate: LocationManagerDelegate?

    // MARK: Istance

    init(delegate: LocationManagerDelegate?) {
        self.delegate = delegate
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.distanceFilter = 5000
    }

    func start() {
        objc_sync_enter(manager)
        if !isMonitoring {
            isMonitoring = true
            self.updateLocation(manager.location)
            manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
        }
        objc_sync_exit(manager)
    }

    func stop() {
        objc_sync_enter(manager)
        if isMonitoring {
            isMonitoring = false
            manager.stopUpdatingLocation()
        }
        objc_sync_exit(manager)
    }

    func getCurrentLocation() -> (location: CLLocation?, name: String?) {
        return (location : lastLocation, name : placemark?.locality)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.updateLocation(location)
    }

    func updateLocation(_ location: CLLocation?) {
        lastLocation = location
        placemark = nil
        if let location = lastLocation {
            LocationManager.getPlacemark(location, completion: { (placemark) -> Void in
                self.placemark = placemark
                self.delegate?.locationManagerDidUpdateLocation(self)
            })
        } else {
            self.delegate?.locationManagerDidUpdateLocation(self)
        }
    }

    // MARK: Static

    static func getPlacemark(_ location: CLLocation, completion : @escaping (_ placemark: CLPlacemark?) -> Void) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            if error == nil {
                completion(placemarks?.first)
            } else {
                completion(nil)
            }
        }

    }
}
