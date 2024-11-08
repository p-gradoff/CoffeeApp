//
//  AuthConfigurator.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation
import UIKit

final class AuthConfigurator {
    static func configureAuthModule() -> UIViewController {
        let validator: AuthValidation = Validator()
        let interfaceBuilder: AccountInterfaceBuilder = InterfaceBuilder()
        let storageService = StorageService.shared
        let networkManager: AuthServiceInput = NetworkService.shared
        
        let view = AuthViewController(with: interfaceBuilder)
        let interactor = AuthInteractor(storageService: storageService, networkManager: networkManager)
        
        let router: AuthRouterInput = AuthRouter()
        
        let presenter = AuthPresenter(
            interactor: interactor,
            router: router,
            view: view,
            validator: validator
        )
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
