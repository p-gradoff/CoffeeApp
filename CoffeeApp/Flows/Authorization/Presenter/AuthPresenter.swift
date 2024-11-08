//
//  AuthPresenter.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation

protocol AuthPresenterInput {
    var output: AuthViewOutput! { get }
}

protocol AuthPresenterOutput { }

final class AuthPresenter {
    private let interactor: AuthInteractorInput
    private let router: AuthRouterInput
    private let view: AuthViewInput
    private let validator: AuthValidation
    
    init(interactor: AuthInteractorInput, router: AuthRouterInput, view: AuthViewInput, validator: AuthValidation) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.validator = validator
    }
}

extension AuthPresenter: AuthViewOutput {
    func authorizeUser(withEmail email: String, password: String) {
        let validation = validator.checkAuthFields(email, password)
        switch validation {
        case nil: interactor.authorizeUser(withEmail: email, password: password)
        case .emailIsIncorrect:
            view.presentAlertController(with: validation!.rawValue, AlertMessage.validationError.rawValue)
            view.resetEmailTextField()
        default:
            view.presentAlertController(with: validation!.rawValue, AlertMessage.validationError.rawValue)
            view.resetPasswordTextField()
        }
    }
}

extension AuthPresenter: AuthInteractorOutput {
    func sendError(with title: String, _ message: String) {
        view.presentAlertController(with: title, message)
    }
    
    func authorizedSuccessfully() {
        self.router.openCoffeeShopsList()
    }
}
