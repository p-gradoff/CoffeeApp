//
//  AuthRouter.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import Foundation
import UIKit

protocol AuthRouterInput: AnyObject {
    func openCoffeeShopsList()
}

final class AuthRouter: AuthRouterInput {
    weak var rootViewController: UIViewController?
    
    func openCoffeeShopsList() {
        let coffeeShopListViewController = ListConfigurator.configureListModule()
        rootViewController?.navigationController?.pushViewController(coffeeShopListViewController, animated: true)
    }
}
