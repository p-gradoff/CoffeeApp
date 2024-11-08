//
//  Location.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation

struct LocationList: Codable {
    let locations: [Location]
}

struct Location: Codable {
    let id: Int
    let name: String
    let point: [Point]
}

struct Point: Codable {
    let latitude: String
    let longtitude: String
}
