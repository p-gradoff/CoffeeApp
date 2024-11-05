//
//  RegexConstants.swift
//  CoffeeApp
//
//  Created by Павел Градов on 05.11.2024.
//

import Foundation

enum RegexConstant: String {
    case email = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
    // case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    case uppercaseLetters = "^[A-Z]+$"
    case lowercaseLetters = "^[a-z]+$"
    case digits = "^[0-9]+$"
}
