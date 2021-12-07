//
//  LoginReactor.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

import ReactorKit
import RxSwift
import RxFlow
import RxRelay

final class LoginReactor: Reactor, Stepper{
    // MARK: - Properties
    private let disposeBag: DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    var initialState: State = .init()
    
    // MARK: - Reactor
    enum Action{
        case updateNickname(name: String)
        case updatePassword(pwd: String)
        case doneDidTap
        case toRegisterButtonDidTap
        case passwordVisiblityButtonDidTap
    }
    enum Mutation{
        case setNickname(name: String)
        case setPassword(pwd: String)
        case setVisible
    }
    struct State{
        var nickname: String = ""
        var password: String = ""
        var isPasswordVisible: Bool = false
    }
}

// MARK: - Mutation
extension LoginReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateNickname(let name):
            return .just(.setNickname(name: name))
        case .updatePassword(let pwd):
            return .just(.setPassword(pwd: pwd))
        case .doneDidTap:
            
            return .empty()
        case .toRegisterButtonDidTap:
            steps.accept(MemoStep.registerIsRequired)
            return .empty()
        case .passwordVisiblityButtonDidTap:
            return .just(.setVisible)
        }
    }
}

// MARK: - Reduce
extension LoginReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setNickname(let name):
            newState.nickname = name
        case .setPassword(let pwd):
            newState.password = pwd
        case .setVisible:
            newState.isPasswordVisible = !newState.isPasswordVisible
        }
        return newState
    }
}

// MARK: - Method
private extension LoginReactor{
    
}
