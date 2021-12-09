//
//  RegisterFlow.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import RxFlow
import RxRelay

struct RegisterStepper: Stepper{
    var steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return MemoStep.registerIsRequired
    }
}
final class RegisterFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    private let stepper: RegisterStepper
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    init(
        with stepper: RegisterStepper
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
        case .registerIsRequired:
            return coordinateToRegister()
        case .alert(let title, let msg):
            return navigateToAlert(title: title, msg: msg)
        default:
            return .none
        }
    }
    
}

// MARK: - Method
private extension RegisterFlow{
    func coordinateToRegister() -> FlowContributors{
        let reactor = RegisterReactor()
        let vc = RegisterVC(reactor: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToAlert(title: String?, msg: String?) -> FlowContributors{
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancle", style: .cancel))
        self.rootVC.present(alert, animated: true)
        return .none
    }
}

