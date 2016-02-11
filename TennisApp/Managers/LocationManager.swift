//
//  LocationManager.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate {
    
    func locationManagerDidUpdateLocation(localizationManager : LocationManager)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    //MARK: Property
    
    private let manager = CLLocationManager()
    private static let geocoder = CLGeocoder()
    
    private var isMonitoring = false
    
    private var lastLocation : CLLocation?
    private var placemark : CLPlacemark?
    
    private let delegate : LocationManagerDelegate?
    
    //MARK: Istance
    
    init(delegate : LocationManagerDelegate?) {
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
    
    func getCurrentLocation() -> (location : CLLocation?, name : String?) {
        return (location : lastLocation, name : placemark?.locality)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.updateLocation(newLocation)
    }
    
    func updateLocation(location : CLLocation?) {
        lastLocation = location
        placemark = nil
        if let location = lastLocation {
            LocationManager.getPlacemark(location, completion: { (placemark) -> Void in
                self.placemark = placemark
                self.delegate?.locationManagerDidUpdateLocation(self)
            })
        }
        else {
            self.delegate?.locationManagerDidUpdateLocation(self)
        }
    }
    
    //MARK: Static
    
    static func getPlacemark(location : CLLocation, completion : (placemark : CLPlacemark?) -> Void) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            if error == nil {
                completion(placemark : placemarks?.first)
            }
            else {
                completion(placemark: nil)
            }
        }
        
    }
}

