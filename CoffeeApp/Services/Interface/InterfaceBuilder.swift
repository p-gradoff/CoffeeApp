//
//  FieldsConstructor.swift
//  CoffeeApp
//
//  Created by Павел Градов on 30.10.2024.
//

import Foundation
import UIKit

protocol AccountInterfaceBuilder {
    func createLabel(withHeader section: SectionType) -> UILabel
    func createTextField(withPlaceholder placeholder: PlaceholderType) -> UITextField
    func createStackView() -> UIStackView
    func createButton(withTitle title: String) -> UIButton
}

final class InterfaceBuilder: AccountInterfaceBuilder {
    func createLabel(withHeader section: SectionType) -> UILabel {
        {
            $0.text = section.rawValue
            $0.textAlignment = .left
            $0.textColor = .primaryText
            $0.font = .getFont(fontType: .displayRegular, size: 15)
            
            $0.setContentHuggingPriority(.required, for: .vertical)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
            return $0
        }(UILabel())
    }
    
    func createTextField(withPlaceholder placeholder: PlaceholderType) -> UITextField {
        {
            $0.layer.cornerRadius = 22
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.primaryText.cgColor
            
            $0.textColor = .primaryText
            $0.placeholder = placeholder.rawValue
            $0.tintColor = UIColor.placeholder
            $0.font = placeholder == .email ? .getFont(fontType: .displayRegular, size: 18) : .getFont(fontType: .montserrat, size: 18)
            
            $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
            $0.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
                            
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.placeholder,
                NSAttributedString.Key.font : UIFont.getFont(fontType: .montserrat)
            ]
            
            $0.attributedPlaceholder = NSAttributedString(string: placeholder.rawValue, attributes: attributes)
            
            let leftView : UIView = UIView(frame: CGRect(x: 0, y: 23, width: 18, height: 1))
            let rightView : UIView = UIView(frame: CGRect(x: $0.frame.width - 18, y: 23, width: 18, height: 1))
    
            $0.leftView = leftView
            $0.leftViewMode = .always
            $0.rightView = rightView
            $0.rightViewMode = .always
            
            return $0
        }(UITextField())
    }
    
    func createStackView() -> UIStackView {
        {
            $0.axis = .vertical
            $0.spacing = 7.5
            $0.distribution = .fill
            return $0
        }(UIStackView())
    }
    
    func createButton(withTitle title: String) -> UIButton {
        {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.cellFilling, for: .normal)
            $0.titleLabel?.font = .getFont(fontType: .displayBold, size: 18)
            $0.backgroundColor = .buttonFilling
            $0.layer.cornerRadius = 22
            return $0
        }(UIButton())
    }
}
