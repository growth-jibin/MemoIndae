//
//  Network.swift
//  Memo
//
//  Created by baegteun on 2021/12/01.
//

import Moya
import RxSwift

protocol UserServiceType: class{
    func checkLoggedin() -> Observable<Bool>
}

final class UserService: UserServiceType{
    static let shared = UserService()
    
    func checkLoggedin() -> Observable<Bool>{
        let isLoggedIn = UserDefaults.standard.bool(forKey: "Loggedin")
        return .just(isLoggedIn)
    }
    
}

