//
//  AppStepper.swift
//  Memo
//
//  Created by baegteun on 2021/11/30.
//

import RxFlow
import RxSwift
import RxRelay

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    func readyToEmitSteps() {
        UserService.shared.checkLoggedin()
            .map{ $0 ? MemoStep.memoListIsRequired : MemoStep.loginIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}
