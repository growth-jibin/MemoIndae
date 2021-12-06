//
//  baseViewModel.swift
//  Memo
//
//  Created by baegteun on 2021/11/24.
//

import RxSwift
import Foundation

protocol baseViewModel{
    associatedtype Input
    associatedtype Output
    
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
