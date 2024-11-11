//
//  LocationModel.swift
//  CoffeeApp
//
//  Created by Павел Градов on 09.11.2024.
//

//struct LocationList: Codable {
//    let locations: Info
//}

// MARK: - LocationElement
struct LocationElement: Codable {
    let id: Int
    let name: String
    let point: Point
}

// MARK: - Point
struct Point: Codable {
    let latitude, longitude: String
}

typealias LocationType = [LocationElement]

struct Distance {
    enum Metric {
        case meters
        case kilometers
    }
    
    let value: Double
    let metric: Metric
}
