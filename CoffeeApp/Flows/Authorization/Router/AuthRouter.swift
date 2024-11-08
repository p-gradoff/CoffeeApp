//
//  AuthRouter.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation

protocol AuthRouterInput {
    func openCoffeeShopsList()
}

final class AuthRouter: AuthRouterInput {
    
    func openCoffeeShopsList() {
        print("opened cofee shops list")
    }
}
