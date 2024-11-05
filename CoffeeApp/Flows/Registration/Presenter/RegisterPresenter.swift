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
}

final class RegisterPresenter {
    private let interactor: RegisterInteractorInput
    private let router: RegisterRouterInput
    private let view: RegisterViewInput
    
    init(interactor: RegisterInteractorInput, router: RegisterRouterInput, view: RegisterViewInput) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    private func checkFieldsValidationOf(_ email: String, _ password: String) -> FieldsError? {
        if let emailError = checkEmail() { return emailError }
        if let passwordError = checkPassword() { return passwordError }
        return nil
        
        func checkEmail() -> FieldsError? {
            let emailPred = NSPredicate(format:"SELF MATCHES[c] %@", RegexConstant.email.rawValue)
            return emailPred.evaluate(with: email) ? nil : FieldsError.emailIsIncorrect
        }
        
        func checkPassword() -> FieldsError? {
            guard password.contains(RegexConstant.uppercaseLetters.rawValue) else {
                return FieldsError.passwordLowercased
            }
            guard password.contains(RegexConstant.lowercaseLetters.rawValue) else {
                return FieldsError.passwordUppercased
            }
            guard password.contains(RegexConstant.digits.rawValue) else {
                return FieldsError.passwordNotContainDigits
            }
            guard password.count > 6 else {
                return FieldsError.passwordTooShort
            }
            return nil
        }
    }
}

extension RegisterPresenter: RegisterViewOutput {
    func presentAlertController(with title: String, _ message: String) {
        view.output?.presentAlertController(with: title, message)
    }
    
    func userRegisterAccount(withEmail email: String, password: String) {
        let validation = checkFieldsValidationOf(email, password)
        if validation != nil {
            self.presentAlertController(with: validation!.rawValue, "Validation Error")
        } else {
            interactor.registerAccount(withEmail: email, password: password)
        }
    }
}

extension RegisterPresenter: RegisterInteractorOutput {    
    func sendError(with title: String, _ message: String) {
        self.presentAlertController(with: title, message)
    }
}
