//
//  InterfacePlaceholder.swift
//  CoffeeApp
//
//  Created by Павел Градов on 04.11.2024.
//

import Foundation

enum SectionType: String {
    case email = "email"
    case password = "Пароль"
    case confirmPassword = "Повторите пароль"
}

enum PlaceholderType: String {
    case email = "example@example.com"
    case password = "******"
}

enum ButtonTitle: String {
    case register = "Регистрация"
    case enter = "Войти"
}
