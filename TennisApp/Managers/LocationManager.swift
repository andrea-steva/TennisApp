//
//  LocationManager.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate: class {

    func locationManagerDidUpdateLocation(_ location: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    // MARK: Shared Instance
    
    class var sharedInstance: LocationManager {
        struct Static {
            static let instance: LocationManager = LocationManager()
        }
        return Static.instance
    }
    
    // MARK: Property

    fileprivate let locationManager = CLLocationManager()
    fileprivate var isMonitoring = false
    fileprivate var lastLocation: CLLocation?
    fileprivate weak var delegate: LocationManagerDelegate?

    // MARK: Instance

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.distanceFilter = 1000
    }

    func start() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func stop() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ locationManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        self.delegate?.locationManagerDidUpdateLocation(location)
    }
    
    func getCurrentLocation() -> CLLocation? {
        return lastLocation
    }
}
