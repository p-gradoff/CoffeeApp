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
