//
//  MemoAPI.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

import Moya

enum MemoAPI{
    case requestLogin(user: User)
    case requestRegister(user: reqUser)
    
}

extension MemoAPI: TargetType{
    var baseURL: URL {
        return URL(string: "http://10.120.74.32:4000")!
    }
    
    var path: String {
        switch self{
        case .requestLogin:
            return "/auth/login"
        case .requestRegister:
            return "/auth/register"
        }
    }
    
    var method: Method {
        switch self{
        case .requestLogin, .requestRegister:
            return .post
        }
    }
    
    var task: Task {
        switch self{
        case .requestLogin(let user):
            return .requestParameters(parameters: user.toDictionary ?? [:], encoding: URLEncoding.default)
        case .requestRegister(let user):
            return .requestParameters(parameters: user.toDictionary ?? [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
