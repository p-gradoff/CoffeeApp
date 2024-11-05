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
}

final class RegisterInteractor: RegisterInteractorInput {
    weak var output: RegisterInteractorOutput?
    var storageService: StorageService!
    var networkManager: RegisterServiceInput!
    
    init(storageService: StorageService!, networkManager: RegisterServiceInput!) {
        self.storageService = storageService
        self.networkManager = networkManager
    }
    
    func registerAccount(withEmail email: String, password: String) {
        let userData = User(login: email, password: password)
        networkManager.registerUser(withData: userData) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let token):
                storageService.saveAuth(token);
                print("success")
                // open next screen
            case .serverError(let err): output?.sendError(with: "Server Error", Errors.messageFor(err: err.message))
            case .networkError(let err): output?.sendError(with: "Network Error", Errors.messageFor(err: err))
            case .authError(let err): output?.sendError(with: "Authorization Error", Errors.messageFor(err: err.message))
            }
        }
    }
    
}
