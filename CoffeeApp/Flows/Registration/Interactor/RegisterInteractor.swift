//
//  RegisterInteractor.swift
//  CoffeeApp
//
//  Created by Павел Градов on 30.10.2024.
//

import Foundation

protocol RegisterInteractorInput: AnyObject {
    var output: RegisterInteractorOutput? { get }
    func registerAccount(withEmail email: String, password: String)
}

protocol RegisterInteractorOutput: AnyObject {
    func sendError(with title: String, _ message: String)
    func registeredSuccessfully()
}

final class RegisterInteractor: RegisterInteractorInput {
    weak var output: RegisterInteractorOutput?
    var networkManager: RegisterServiceInput!
    
    init(networkManager: RegisterServiceInput!) {
        self.networkManager = networkManager
    }
    
    func registerAccount(withEmail email: String, password: String) {
        let userData = User(login: email, password: password)
        networkManager.registerUser(withData: userData) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                // storageService.saveAuth(token);
                // print("success")
                output?.registeredSuccessfully()
            case .serverError(let err): output?.sendError(
                with: AlertMessage.serverError.rawValue, Errors.messageFor(err: err.message)
            )
            case .networkError(let err): output?.sendError(
                with: AlertMessage.networkError.rawValue, Errors.messageFor(err: err)
            )
            case .authError(let err): output?.sendError(
                with: AlertMessage.authorizationError.rawValue, Errors.messageFor(err: err.message)
            )
            }
        }
    }
    
}
