//
//  LoginVC.swift
//  Memo
//
//  Created by baegteun on 2021/11/24.
//

import UIKit
import Then
import SnapKit
import RxSwift

final class LoginVC: baseVC<LoginVM>{
    // MARK: - Properties
    private let welcomeLabel = UILabel().then {
        $0.text = "Welcome \nBack"
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    private let nameTextField = AuthTextField(icon: .init(systemName: "person") ?? .init(), placeholder: "Nickname")
    
    private let passwordTextField = AuthTextField(icon: .init(systemName: "lock") ?? .init(), placeholder: "Password")
    
    private let passwordVisibleButton = UIButton()
    
    private let doneButton = UIButton()
    
    private lazy var stack = UIStackView(arrangedSubviews: [nameTextField, passwordTextField, doneButton]).then {
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    
    // MARK: - SetUI
    override func addView() {
//        [welcomeLabel, stack, passwordVisibleButton].forEach{view.addSubview($0)}
        [welcomeLabel, nameTextField, passwordVisibleButton].forEach{view.addSubview($0)}
    }
    override func setLayout() {
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(bound.height*0.15)
        }
        stack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeLabel.snp.bottom).inset(bound.height*0.1)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.1)
        }
        passwordVisibleButton.snp.makeConstraints {
            $0.trailing.equalTo(stack.snp.trailing)
            $0.centerY.equalTo(stack)
        }
    }
    override func configureVC() {
        super.configureVC()
        
    }
    
    override func bind() {
        let input = LoginVM.Input(
            nameText: nameTextField.textField.rx.text.orEmpty.asObservable(),
            passwordText: passwordTextField.textField.rx.text.orEmpty.asObservable(),
            passwordVisibleDidTap: passwordVisibleButton.rx.tap.asObservable(),
            doneDidTap: doneButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.pwdIsVisible
            .bind(to: passwordTextField.textField.rx.isSecureTextEntry)
            .disposed(by: disposeBag)
        
        output.buttonColor
            .bind(to: doneButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        output.buttonIsEnabled
            .bind(to: doneButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.navigateToRegister
            .subscribe(onNext: { [weak self] step in 
                self?.viewModel.navigateToRegister(step)
            })
            .disposed(by: disposeBag)
    }
}
