//
//  LocationService.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation
import CoreLocation
import UIKit

enum LocationResult<T> {
    case success(_ distance: Double)
    case locationError(_ error: String)
}

protocol LocationDistance: AnyObject {
    func getDistance(fromUserTo shopPoint: Point, completion: (LocationResult<Double>) -> Void)
}

final class LocationService: NSObject {
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestLocation()
            }
        }
    }
    
    private func getShopLocation(from point: Point) -> CLLocation {
        let latitude = Double(point.latitude) ?? 0.0
        let longtitude = Double(point.longtitude) ?? 0.0
        
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
        self.userLocation = location // user location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        self.userLocation = nil
    }
}

extension LocationService: LocationDistance {
    func getDistance(fromUserTo shopPoint: Point, completion: (LocationResult<Double>) -> Void) {
        guard let userLocation else {
            completion(.locationError(LocationError.ERR_CANT_GET_USER_LOCATION))
            return
        }
        
        let shopLocation = getShopLocation(from: shopPoint)
        let distance = userLocation.distance(from: shopLocation)
        completion(.success(distance))
    }
}
