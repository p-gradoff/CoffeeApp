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
}

extension RegisterPresenter: RegisterViewOutput {
    func userRegisterAccount(withEmail email: String, password: String) {
        interactor.registerAccount(withEmail: email, password: password)
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    func didReceive(error: String) {
        //
    }
    
    func didRegisterAccount(withEmail email: String) {
        //
    }
    
    
}
