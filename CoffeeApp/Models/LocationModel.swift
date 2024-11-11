//
//  LocationModel.swift
//  CoffeeApp
//
//  Created by Павел Градов on 09.11.2024.
//

struct LocationList: Codable {
    let locations: [Location]
}

struct Location: Codable {
    let id: Int
    let name: String
    let point: Point
}

struct Point: Codable {
    let latitude: String
    let longtitude: String
}

struct Distance {
    enum Metric {
        case meters
        case kilometers
    }
    
    let value: Double
    let metric: Metric
}
