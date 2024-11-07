//
//  RegisterRouter.swift
//  CoffeeApp
//
//  Created by Павел Градов on 30.10.2024.
//

import Foundation
import UIKit

protocol RegisterRouterInput {
    func openCoffeeShopsList()
}

final class RegisterRouter: RegisterRouterInput {
    weak var rootViewController: UIViewController?
    
    func openCoffeeShopsList() {
        let coffeShopsListViewController = LocationView()
        rootViewController?.navigationController?.pushViewController(coffeShopsListViewController, animated: true)
    }
    
}
