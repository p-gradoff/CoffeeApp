//
//  NetworkModel.swift
//  CoffeeApp
//
//  Created by Павел Градов on 05.11.2024.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    let tokenLifetime: Int
}

struct ErrorResponse: Codable {
    let code: Int
    let message: String
    
    func isAuth() -> Bool {
        return Errors.isAuthError(err: message)
    }
}
