//
//  LoginVM.swift
//  Memo
//
//  Created by baegteun on 2021/11/24.
//

import RxSwift
import RxCocoa
import RxFlow

final class LoginVM: baseViewModel, Stepper{
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    struct Input{
        var nameText: Observable<String>
        var passwordText: Observable<String>
        var passwordVisibleDidTap: Observable<Void>
        var doneDidTap: Observable<Void>
    }
    
    struct Output{
        var pwdIsVisible: Observable<Bool>
        var buttonIsEnabled: Observable<Bool>
        var buttonColor: Observable<UIColor>
        var navigateToRegister: Observable<MemoStep>
    }
    
    var disposeBag: DisposeBag = .init()
    
    // MARK: - Method
    
    func transform(input: Input) -> Output {
        let pwdVisiblity = BehaviorRelay(value: true)
        
        let name = input.nameText.map{$0}
        let pwd = input.passwordText.map{$0}
        
        input
            .passwordVisibleDidTap
            .subscribe(onNext: {
                pwdVisiblity.accept(!pwdVisiblity.value)
            })
            .disposed(by: disposeBag)
        
        let valid = Observable.combineLatest(name, pwd).map(isValid).share(replay: 2)
        
        let validation = valid
        
        let btnColor = valid.map(convertButtonColor)
       
        return Output(
            pwdIsVisible: pwdVisiblity.asObservable(),
            buttonIsEnabled: validation,
            buttonColor: btnColor,
            navigateToRegister: .just(.registerIsRequired)
        )
        
    }
    
    func navigateToRegister(_ nextStep: MemoStep){
        steps.accept(nextStep)
    }
    
}
private func isValid(name: String?, password: String?) -> Bool{
    return name?.isEmpty == false && password?.isEmpty == false
}

private func convertButtonColor(valid: Bool) -> UIColor{
    return valid ? UIColor.init(red: 105, green: 210, blue: 162, alpha: 1) : UIColor.init(red: 0, green: 121, blue: 66, alpha: 1)
}
