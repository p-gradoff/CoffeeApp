//
//  ListConfigurator.swift
//  CoffeeApp
//
//  Created by Павел Градов on 09.11.2024.
//

import UIKit

final class ListConfigurator {
    static func configureListModule() -> UIViewController {
        let storageService = StorageService.shared
        let networkService = NetworkService.shared
        let locationService: LocationDistance = LocationService()
        let distanceManager = DistanceManager()
        
        let interactor = ListInteractor(storageService: storageService, networkService: networkService, locationService: locationService, distanceManager: distanceManager)
        
        let router = ListRouter()
        let view = ListView()
        let presenter = ListPresenter(interactor: interactor, router: router, view: view)
        
        view.output = presenter
        interactor.output = presenter
        return view
    }
}
