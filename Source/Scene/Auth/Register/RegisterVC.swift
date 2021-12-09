//
//  RegisterVC.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import ReactorKit
import Then
import SnapKit
import RxCocoa

final class RegisterVC: baseVC<RegisterReactor>{
    // MARK: - Properties
    private let getStartLabel = UILabel().then {
        $0.text = "Get's started"
        $0.textColor = .black
        $0.font = UIFont(name: "Zapfino", size: 30)
        $0.textAlignment = .left
    }
    
    private let nicknameTextField = AuthTextField(icon: UIImage(systemName: "person") ?? .init(), placeholder: "Nickname")
    
    private let passwordTextField = AuthTextField(icon: UIImage(systemName: "lock") ?? .init(), placeholder: "Password").then {
        $0.isSecureTextEntry = true
    }
    
    private let chkPasswordTextField = AuthTextField(icon: UIImage(systemName: "lock") ?? .init(), placeholder: "Password Check").then {
        $0.isSecureTextEntry = true
    }
    
    private let registerButton = UIButton().then {
        $0.setTitle("Register", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 15
    }
    
    private lazy var stack = UIStackView(arrangedSubviews: [nicknameTextField, passwordTextField, chkPasswordTextField, registerButton]).then {
        $0.axis = .vertical
        $0.spacing = 40
    }
    
    // MARK: - UI
    override func addView() {
        [getStartLabel, stack].forEach{ view.addSubview($0) }
    }
    override func setLayout() {
        getStartLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(bound.height*0.1)
        }
        stack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(getStartLabel.snp.bottom).offset(bound.height*0.1)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.05)
        }
        registerButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    override func configureVC() {
        super.configureVC()
    }
    
    // MARK: - Reactor
    override func bindView(reactor: RegisterReactor) {
        nicknameTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updateNickname(name: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updatePassword(pwd: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        chkPasswordTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updateChkPassword(pwd: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .map { Reactor.Action.registerButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    override func bindState(reactor: RegisterReactor) {
        
    }
    override func bindAction(reactor: RegisterReactor) {
        
    }
}
