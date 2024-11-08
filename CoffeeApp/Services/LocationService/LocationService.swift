//
//  LocationService.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation
import CoreLocation
import UIKit

protocol Distance: AnyObject {
    func getDistance(from shopPoint: Point) -> Double
}

final class LocationService: NSObject {
    private let locationManager = CLLocationManager()
    private var locationResult: Result<CLLocation, Error>!
    
    init(location: CLLocation!) {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        }
    }
    
    private func getLocation(from point: Point) -> CLLocation? {
        guard let latitude = Double(point.latitude), let longtitude = Double(point.longtitude) else {
            return nil
        }
        
        let location = CLLocation(latitude: latitude, longitude: longtitude)
        return location
    }
    
    private func preventRetainCycle() {
        locationManager.delegate = nil
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.locationResult = .success(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        self.locationResult = .failure(error)
    }
}

extension LocationService: Distance {
    func getDistance(from shopPoint: Point) -> Double {
        guard let shopLocation = getLocation(from: shopPoint) else {
            // send error
            return -1
        }
        
        switch locationResult {
        case .success(let userlocation):
            let distance = userlocation.distance(from: shopLocation)
            return distance
        case .failure(let error):
            // make error handling
            return 0
        case .none:
            return -1
        }
    }
}
