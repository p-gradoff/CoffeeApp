//
//  RegisterPresenter.swift
//  CoffeeApp
//
//  Created by Павел Градов on 30.10.2024.
//

import Foundation
import UIKit

protocol RegisterPresenterInput: AnyObject {
    var output: RegisterPresenterOutput! { get }
}

protocol RegisterPresenterOutput: AnyObject {
    func didRegister()
}

final class RegisterPresenter {
    private let interactor: RegisterInteractorInput
    private let router: RegisterRouterInput
    private let view: RegisterViewInput
    private let validator: RegisterValidation
    
    init(interactor: RegisterInteractorInput, router: RegisterRouterInput, view: RegisterViewInput, validator: RegisterValidation) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.validator = validator
    }
}

extension RegisterPresenter: RegisterViewOutput {
    func presentAlertController(with title: String, _ message: String) {
        view.presentAlertController(with: title, message)
    }
    
    func userRegisterAccount(withEmail email: String, password: String, confirmPassword: String) {
        let validation = validator.checkRegisterFields(email, password, confirmPassword)
        switch validation {
        case nil: interactor.registerAccount(withEmail: email, password: password)
        case .emailIsIncorrect:
            self.presentAlertController(with: validation!.rawValue, AlertMessage.validationError.rawValue)
            view.resetEmailTextField()
        default:
            self.presentAlertController(with: validation!.rawValue, AlertMessage.validationError.rawValue)
            view.resetPasswordsTextField()
        }
    }
}

extension RegisterPresenter: RegisterInteractorOutput {    
    func sendError(with title: String, _ message: String) {
        self.presentAlertController(with: title, message)
    }
    
    func registerSuccessfully() {
        self.router.openCoffeeShopsList()
    }
}
