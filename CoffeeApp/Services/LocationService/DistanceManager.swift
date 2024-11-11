//
//  TableDataManager.swift
//  CoffeeApp
//
//  Created by Павел Градов on 09.11.2024.
//

import Foundation

enum DistanceMetric {
    case meters(Int)
    case kilometers(Int)
}

final class DistanceManager {
    private let distanceString = "от вас"
    
    func getDistanceMetric(_ distance: Double) -> String {
        let intDistance = Int(distance)
        let formattedDistance = intDistance >= 1000 ?
        DistanceMetric.kilometers(intDistance / 1000) : DistanceMetric.meters(intDistance)
        
        switch formattedDistance {
        case .meters(let int):
            return "\(int) м \(distanceString)"
        case .kilometers(let int):
            return "\(int) км \(distanceString)"
        }
    }
}
