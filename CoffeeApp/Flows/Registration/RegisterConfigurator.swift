//
//  RegisterConfigurator.swift
//  CoffeeApp
//
//  Created by Павел Градов on 04.11.2024.
//

import UIKit

final class RegisterConfigurator {
    static func configureRegisterModule() -> UIViewController {
        let interfaceBuilder = InterfaceBuilder()
        let validator = Validator()
        let networkService = NetworkService.shared
        
        let view = RegisterView(with: interfaceBuilder)
        let interactor = RegisterInteractor(networkManager: networkService)
        
        let router = RegisterRouter()
        router.rootViewController = view
        
        let presenter = RegisterPresenter(
            interactor: interactor,
            router: router,
            view: view,
            validator: validator
        )
        
        interactor.output = presenter
        view.output = presenter
        
        return view
    }
}
