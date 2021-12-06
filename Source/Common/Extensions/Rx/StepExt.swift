//
//  StepExt.swift
//  Memo
//
//  Created by baegteun on 2021/11/30.
//

import RxFlow

extension Step{
    var asMemoStep: MemoStep?{
        return self as? MemoStep
    }
}
