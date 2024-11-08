//
//  PresenterProtocol.swift
//  CoffeeApp
//
//  Created by Павел Градов on 02.11.2024.
//

import Foundation
import UIKit

protocol InterfaceProvider {
    func getInterfaceBuilder() -> InterfaceBuilder
}

protocol AlertProvider {
    func getController(with title: String, _ message: String) -> UIAlertController
}
extension AlertProvider {
    func getController(with title: String, _ message: String) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertAction)
        return alertController
    }
}
