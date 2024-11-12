//
//  ListInteractor.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation

protocol ListInteractorInput: AnyObject {
    var output: ListInteractorOutput? { get }
    func getDistances()
}

protocol ListInteractorOutput: AnyObject {
    func sendShopsInfo(_ info: [ShopInfo])
    func sendError(with title: String, _ message: String)
}

final class ListInteractor {
    weak var output: ListInteractorOutput?
    private let storageService: StorageService
    private let networkService: LocationListServiceInput
    private let locationService: LocationDistance
    private let distanceManager: DistanceManager
    
    init(storageService: StorageService, networkService: LocationListServiceInput, locationService: LocationDistance, distanceManager: DistanceManager) {
        self.storageService = storageService
        self.networkService = networkService
        self.locationService = locationService
        self.distanceManager = distanceManager
    }
    
//    private func getShopLocations() -> LocationType {
//        var locations: LocationType = []
//        networkService.loadLocations { [weak self] result in
//            guard let self = self else { return }
//            // получаем список всех локаций
//            switch result {
//            case .success(let locationList):
//                locations = locationList
//            default:
//                output?.sendError(with: AlertMessage.serverError.rawValue, Errors.messageFor(err: "Network error"))
//            }
//            return locations
//        }
//    }
}

extension ListInteractor: ListInteractorInput {
    func getDistances() {
        networkService.loadLocations { [weak self] result in
            guard let self = self else { return }
            // получаем список всех локаций
            switch result {
            case .success(let locationList):
                var shopsData: [ShopInfo] = []
                let shopLocations = locationList
                
                for shop in shopLocations {
                    locationService.getDistance(fromUserTo: shop.point) { [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success(let distance):
                            let shopDistanceString = distanceManager.getDistanceMetric(distance)
                            let shopInfo = ShopInfo(name: shop.name, distance: shopDistanceString)
                            shopsData.append(shopInfo)
                        case .locationError(let err):
                            output?.sendError(
                                with: err, AlertMessage.locationError.rawValue)
                        }
                    }
                }
                output?.sendShopsInfo(shopsData)
            default:
                output?.sendError(
                    with: AlertMessage.serverError.rawValue, Errors.messageFor(err: AlertMessage.networkError.rawValue)
                )
            }
        }
    }
}
