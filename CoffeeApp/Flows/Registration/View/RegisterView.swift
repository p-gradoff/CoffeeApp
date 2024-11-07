//
//  RegisterViewController.swift
//  CoffeeApp
//
//  Created by Павел Градов on 30.10.2024.
//

import Foundation
import UIKit
import SnapKit

// MARK: made View, ViewInput, ViewOutput

protocol RegisterViewInput: AnyObject {
    var output: RegisterViewOutput? { get set }
    func presentAlertController(with title: String, _ message: String)
    func resetEmailTextField()
    func resetPasswordsTextField()
}

protocol RegisterViewOutput: AnyObject {
    func userRegisterAccount(withEmail email: String, password: String, confirmPassword: String)
}

final class RegisterView: UIViewController {
    
    var output: RegisterViewOutput? // make DI
    private let interfaceBuilder: AccountInterfaceBuilder!
    
    private lazy var emailLabel: UILabel = interfaceBuilder.createLabel(withHeader: .email)
    private lazy var emailTextField: UITextField = interfaceBuilder.createTextField(withPlaceholder: .email)
    private lazy var emailStackView: UIStackView = interfaceBuilder.createStackView()
    
    private lazy var passwordLabel: UILabel = interfaceBuilder.createLabel(withHeader: .password)
    private lazy var passwordTextField: UITextField = interfaceBuilder.createTextField(withPlaceholder: .password)
    private lazy var passwordStackView: UIStackView = interfaceBuilder.createStackView()
    
    private lazy var confirmPasswordLabel: UILabel = interfaceBuilder.createLabel(withHeader: .confirmPassword)
    private lazy var confirmPasswordTextField: UITextField = interfaceBuilder.createTextField(withPlaceholder: .password)
    private lazy var confirmPasswordStackView: UIStackView = interfaceBuilder.createStackView()
    
    private lazy var registerButton: UIButton = interfaceBuilder.createButton(withTitle: ButtonTitle.register.rawValue)
    
    private lazy var fieldsStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 24
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    init(with interfaceBuilder: AccountInterfaceBuilder!) {
        self.interfaceBuilder = interfaceBuilder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Регистрация"
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        setupStackViews()
        view.addSubviews(fieldsStackView, registerButton)
        
        fieldsStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(278)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(267)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(fieldsStackView.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(fieldsStackView.snp.horizontalEdges)
            $0.height.equalTo(48)
        }
        
        func setupStackViews() {
            [emailLabel, emailTextField].forEach { view in emailStackView.addArrangedSubview(view) }
            [passwordLabel, passwordTextField].forEach { view in passwordStackView.addArrangedSubview(view) }
            [confirmPasswordLabel, confirmPasswordTextField].forEach { view in confirmPasswordStackView.addArrangedSubview(view) }
            [emailStackView, passwordStackView, confirmPasswordStackView].forEach { view in fieldsStackView.addArrangedSubview(view) }
        }
    }
    
    @objc private func registerButtonPressed() {
        output?.userRegisterAccount(
            withEmail: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            confirmPassword: confirmPasswordTextField.text ?? ""
        )
    }
}

extension RegisterView: RegisterViewInput {
    func presentAlertController(with title: String, _ message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    func resetEmailTextField() {
        emailTextField.text = ""
    }
    
    func resetPasswordsTextField() {
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}
