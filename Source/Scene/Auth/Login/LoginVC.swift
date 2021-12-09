//
//  LoginVC.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class LoginVC: baseVC<LoginReactor>{
    // MARK: - Properties
    private let welcomeLabel = UILabel().then {
        $0.text = "Welcome !"
        $0.font = UIFont(name: "Zapfino", size: 30)
        $0.textAlignment = .left
    }
    
    private let nameTextField = AuthTextField(icon: UIImage(systemName: "person") ?? .init(), placeholder: "Nickname")
    
    private let passwordTextField = AuthTextField(icon: UIImage(systemName: "lock") ?? .init(), placeholder: "Password").then {
        $0.isSecureTextEntry = true
    }
    
    private let doneButton = UIButton().then {
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 15
    }
    
    private lazy var stack = UIStackView(arrangedSubviews: [nameTextField, passwordTextField, doneButton]).then {
        $0.axis = .vertical
        $0.spacing = 40
    }
    
    private let toRegisterButton = UIButton().then {
        $0.setTitle("Register Now", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
    }
    
    // MARK: - UI
    override func addView(){
        [welcomeLabel, stack, toRegisterButton].forEach{ view.addSubview($0) }
    }
    override func setLayout() {
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(bound.height*0.1)
        }
        stack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(bound.height*0.1)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.05)
        }
        doneButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        toRegisterButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    override func configureVC() {
        super.configureVC()
        self.title = "Login"
        self.navigationItem.titleView = .init()
    }
    
    // MARK: - Reactor
    override func bindView(reactor: LoginReactor) {
        toRegisterButton.rx.tap
            .map { Reactor.Action.toRegisterButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updateNickname(name: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updatePassword(pwd: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        doneButton.rx.tap
            .map { Reactor.Action.doneDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: LoginReactor) {
        
    }
    override func bindAction(reactor: LoginReactor) {
        
    }
}
