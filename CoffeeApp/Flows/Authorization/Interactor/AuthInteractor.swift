//
//  AuthInteractor.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation

protocol AuthInteractorInput: AnyObject {
    var output: AuthInteractorOutput? { get }
    func authorizeUser(withEmail email: String, password: String)
}

protocol AuthInteractorOutput: AnyObject {
    func sendError(with title: String, _ message: String)
    func authorizedSuccessfully()
}

final class AuthInteractor: AuthInteractorInput {
    weak var output: AuthInteractorOutput?
    var storageService: StorageService!
    var networkManager: AuthServiceInput!
    
    init(storageService: StorageService!, networkManager: AuthServiceInput!) {
        self.storageService = storageService
        self.networkManager = networkManager
    }
    
    func authorizeUser(withEmail email: String, password: String) {
        let userData = User(login: email, password: password)
        networkManager.authorizeUser(withData: userData) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let token):
                storageService.saveAuth(token)
                output?.authorizedSuccessfully()
            case .serverError(let err):
                output?.sendError(with: AlertMessage.serverError.rawValue, Errors.messageFor(err: err.message))
            case .networkError(let err):
                output?.sendError(with: AlertMessage.networkError.rawValue, Errors.messageFor(err: err))
            case .authError(let err):
                output?.sendError(with: AlertMessage.authorizationError.rawValue, Errors.messageFor(err: err.message))
            }
        }
    }
    
    func authorizedSuccessfully() {
        // router open next screen
    }
}
