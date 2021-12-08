//
//  User.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

struct User: Codable{
    let nickname: String
    let password: String
    init(nickname: String, password: String){
        self.nickname = nickname
        self.password = password
    }
}

struct reqUser: Codable{
    let nickname: String
    let password: String
    let checkPassword: String
    enum CodingKeys: String, CodingKey{
        case nickname = "nickname"
        case password = "password"
        case checkPassword = "checkpassword"
    }
}
