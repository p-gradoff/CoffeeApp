//
//  AuthViewController.swift
//  CoffeeApp
//
//  Created by Павел Градов on 08.11.2024.
//

import UIKit
import SnapKit

protocol AuthViewInput: AnyObject {
    var output: AuthViewOutput? { get set }
    func presentAlertController(with title: String, _ message: String)
    func resetEmailTextField()
    func resetPasswordTextField()
}

protocol AuthViewOutput: AnyObject {
    func authorizeUser(withEmail email: String, password: String)
}

final class AuthViewController: UIViewController {
    
    var output: AuthViewOutput?
    private let interfaceBuilder: AccountInterfaceBuilder
    
    private lazy var emailLabel: UILabel = interfaceBuilder.createLabel(withHeader: .email)
    private lazy var emailTextField: UITextField = interfaceBuilder.createTextField(withPlaceholder: .email)
    private lazy var emailStackView: UIStackView = interfaceBuilder.createStackView()
    
    private lazy var passwordLabel: UILabel = interfaceBuilder.createLabel(withHeader: .password)
    private lazy var passwordTextField: UITextField = interfaceBuilder.createTextField(withPlaceholder: .password)
    private lazy var passwordStackView: UIStackView = interfaceBuilder.createStackView()
    
    private lazy var fieldsStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 24
        $0.distribution = .fillEqually
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    private lazy var authButton: UIButton = interfaceBuilder.createButton(withTitle: ButtonTitle.enter.rawValue)

    init(with interfaceBuilder: AccountInterfaceBuilder) {
        self.interfaceBuilder = interfaceBuilder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Вход"
        navigationItem.hidesBackButton = true
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        authButton.addTarget(self, action: #selector(authButtonPressed), for: .touchUpInside)
        
        setupStackViews()
        view.addSubviews(fieldsStackView, authButton)
        
        fieldsStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(278)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(170)
        }
        
        authButton.snp.makeConstraints {
            $0.top.equalTo(fieldsStackView.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(fieldsStackView.snp.horizontalEdges)
            $0.height.equalTo(48)
        }
        
        func setupStackViews() {
            [emailLabel, emailTextField].forEach { view in emailStackView.addArrangedSubview(view) }
            [passwordLabel, passwordTextField].forEach { view in passwordStackView.addArrangedSubview(view) }
            [emailStackView, passwordStackView].forEach { view in fieldsStackView.addArrangedSubview(view) }
        }
    }

    @objc private func authButtonPressed() {
        output?.authorizeUser(
            withEmail: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
}

extension AuthViewController: AuthViewInput, AlertProvider {
    func presentAlertController(with title: String, _ message: String) {
        let controller = getController(with: title, message)
        self.present(controller, animated: true)
    }
    
    func resetEmailTextField() {
        emailTextField.text = ""
    }
    
    func resetPasswordTextField() {
        passwordTextField.text = ""
    }
}
