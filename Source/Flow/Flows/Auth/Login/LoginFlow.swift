//
//  LoginFlow.swift
//  Memo
//
//  Created by baegteun on 2021/12/01.
//

import RxFlow
import RxRelay

struct LoginStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return MemoStep.loginIsRequired
    }
}

final class LoginFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    private let rootVC = UINavigationController()
    private let stepper: LoginStepper
    
    // MARK: - Init
    init (
        with stepper: LoginStepper
    ){
        self.stepper = stepper
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asMemoStep else { return .none }
        
        switch step{
        case .loginIsRequired:
            return coordinateToLogin()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension LoginFlow{
    func coordinateToLogin() -> FlowContributors{
        let vm = LoginVM()
        let vc = LoginVC(vm: vm)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
}
