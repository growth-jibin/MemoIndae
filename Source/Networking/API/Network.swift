//
//  Network.swift
//  Memo
//
//  Created by baegteun on 2021/12/01.
//

import Moya
import RxSwift

protocol NetworkType: class{
    func checkLoggedin() -> Observable<Bool>
}

final class Network: NetworkType{
    static let shared = Network()
    func checkLoggedin() -> Observable<Bool>{
        let isLoggedIn = UserDefaults.standard.bool(forKey: "Loggedin")
        return .just(isLoggedIn)
    }
    
}

