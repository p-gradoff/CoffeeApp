//
//  FieldsErrors.swift
//  CoffeeApp
//
//  Created by Павел Градов on 05.11.2024.
//

import Foundation

enum FieldsError: String {
    case emailIsIncorrect = "Email is incorrect"
    case passwordTooShort = "Password is too short. Please use at least 6 characters"
    case passwordLowercased = "Password must contain at least one uppercase character"
    case passwordUppercased = "Password must contain at least one lowercase character"
    case passwordNotContainDigits = "Password must contain at least one digit"
}
