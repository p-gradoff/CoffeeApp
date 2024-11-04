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
    func didReceive(error: String)
    func didRegisterAccount(withEmail email: String)
}

final class RegisterInteractor: RegisterInteractorInput {
    weak var output: RegisterInteractorOutput?
    
    func registerAccount(withEmail email: String, password: String) {
        // register accout
    }
    
    func didReceive(error: String) {
        //
    }
    
    func didRegisterAccount(withEmail email: String) {
        self.output?.didRegisterAccount(withEmail: email)
    }
    
    
}
