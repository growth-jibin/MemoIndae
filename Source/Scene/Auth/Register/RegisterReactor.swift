//
//  RegisterReactor.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

import ReactorKit
import RxFlow
import RxRelay

final class RegisterReactor: Reactor, Stepper{
    // MARK: - Properties
    private let disposeBag: DisposeBag = .init()
    
    var steps: PublishRelay<Step> = .init()
    
    var initialState: State = .init()
    
    // MARK: - Reactor
    enum Action{
        case updateNickname(name: String)
        case updatePassword(pwd: String)
        case updateChkPassword(pwd: String)
        case registerButtonDidTap
        case loginButtonDidTap
    }
    enum Mutation{
        case setName(name: String)
        case setPassword(pwd: String)
        case setChkPassword(pwd: String)
    }
    struct State{
        var nickname: String = ""
        var password: String = ""
        var checkPassword: String = ""
    }
}

// MARK: - Mutate
extension RegisterReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .updateNickname(let name):
            return .just(.setName(name: name))
        case .updatePassword(let pwd):
            return .just(.setPassword(pwd: pwd))
        case .updateChkPassword(let pwd):
            return .just(.setChkPassword(pwd: pwd))
        case .registerButtonDidTap:
            
            return .empty()
        case .loginButtonDidTap:
            steps.accept(MemoStep.loginIsRequired)
            return .empty()
        }
    }
}

// MARK: - Reduce
extension RegisterReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setName(let name):
            newState.nickname = name
        case .setPassword(let pwd):
            newState.password = pwd
        case .setChkPassword(let pwd):
            newState.checkPassword = pwd
        }
        return newState
    }
}

// MARK: - Method
extension RegisterReactor{
    
}
