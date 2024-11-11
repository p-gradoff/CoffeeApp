//
//  Validator.swift
//  CoffeeApp
//
//  Created by Павел Градов on 06.11.2024.
//

import Foundation

protocol RegisterValidation: AnyObject {
    func checkRegisterFields(_ email: String, _ password: String, _ confirmPassword: String) -> FieldsError?
}

protocol AuthValidation: AnyObject {
    func checkAuthFields(_ email: String, _ password: String) -> FieldsError?
}

enum AlertMessage: String {
    case validationError = "Validation Error"
    case serverError = "Server Error"
    case networkError = "Network Error"
    case authorizationError = "Authorization Error"
    case locationError = "Location Error"
}

final class Validator {
    private func checkEmail(_ email: String) -> FieldsError? {
        let emailPred = NSPredicate(format:"SELF MATCHES[c] %@", RegexConstant.email.rawValue)
        return emailPred.evaluate(with: email) ? nil : FieldsError.emailIsIncorrect
    }
    
    private func checkPassword(_ password: String) -> FieldsError? {
        var regex = RegexConstant.getRegex(RegexConstant.uppercaseLetters)
        guard password.contains(regex) else {
            return FieldsError.passwordLowercased
        }
        
        regex = RegexConstant.getRegex(RegexConstant.lowercaseLetters)
        guard password.contains(regex) else {
            return FieldsError.passwordUppercased
        }
        
        regex = RegexConstant.getRegex(RegexConstant.digits)
        guard password.contains(regex) else {
            return FieldsError.passwordNotContainDigits
        }
        
        guard password.count >= 6 else {
            return FieldsError.passwordTooShort
        }
        return nil
    }
    
    private func checkPasswordConfirmation(_ password: String, _ confirmPassword: String) -> FieldsError? {
        guard password == confirmPassword else {
            return FieldsError.passwordsDontMatch
        }
        return nil
    }
}

extension Validator: RegisterValidation {
    func checkRegisterFields(_ email: String, _ password: String, _ confirmPassword: String) -> FieldsError? {
        if let isEmailCorrect = checkEmail(email) { return isEmailCorrect }
        if let isPasswordCorrect = checkPassword(password) { return isPasswordCorrect }
        if let isPasswordConfirmed = checkPasswordConfirmation(password, confirmPassword) { return isPasswordConfirmed }
        
        return nil
    }
}

extension Validator: AuthValidation {
    func checkAuthFields(_ email: String, _ password: String) -> FieldsError? {
        if let isEmailCorrect = checkEmail(email) { return isEmailCorrect }
        if let isPasswordCorrect = checkPassword(password) { return isPasswordCorrect }
        
        return nil
    }
}
