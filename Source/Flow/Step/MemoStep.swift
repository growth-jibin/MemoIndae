//
//  MemoStep.swift
//  Memo
//
//  Created by baegteun on 2021/11/30.
//

import RxFlow

enum MemoStep: Step{
    // Global
    case alert(title: String?, message: String?)
    case dismiss
    
    // Auth
    case loginIsRequired
    case registerIsRequired
    
    // Memo
    case memoListIsRequired
    case memoCreateIsRequired
    case memoDetailIsRequired
    case memoComposeIsRequired
    
}
