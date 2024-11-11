//
//  RegisterRouter.swift
//  CoffeeApp
//
//  Created by Павел Градов on 30.10.2024.
//

import Foundation
import UIKit

protocol RegisterRouterInput {
    func openAuthorization()
}

final class RegisterRouter: RegisterRouterInput {
    weak var rootViewController: UIViewController?
    
    func openAuthorization() {
        let authViewController = AuthConfigurator.configureAuthModule()
        rootViewController?.navigationController?.pushViewController(authViewController, animated: true)
    }
    
}
