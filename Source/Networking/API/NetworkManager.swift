//
//  NetworkManager.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Moya
import RxSwift

protocol NetworkManagerType: class{
    var provider: MoyaProvider<MemoAPI> { get }
}

final class NetworkManager: NetworkManagerType{
    static let shared = NetworkManager()
    
    var provider: MoyaProvider<MemoAPI>
    
    private let disposeBag: DisposeBag = .init()
    
    init(provider: MoyaProvider<MemoAPI> = .init()){
        self.provider = provider
    }
    
    func requestLogin(_ user: User) -> Single<Response>{
        return provider.rx.request(.requestLogin(user: user), callbackQueue: .global())
    }
}
