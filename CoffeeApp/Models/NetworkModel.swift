//
//  NetworkModel.swift
//  CoffeeApp
//
//  Created by Павел Градов on 05.11.2024.
//

import Foundation

struct TokenResponse: Codable {
    let token: String
    let tokenLifetime: Int32?
}

struct ErrorResponse: Codable {
    let code: Int
    let message: String
    
    func isAuth() -> Bool {
        return Errors.isAuthError(err: message)
    }
}
