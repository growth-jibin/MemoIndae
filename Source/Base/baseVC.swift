//
//  baseVC.swift
//  Memo
//
//  Created by baegteun on 2021/11/24.
//

import UIKit
import RxSwift

class baseVC<T: baseViewModel>: UIViewController{
    // MARK: - Properties
    let bound = UIScreen.main.bounds
    let disposeBag: DisposeBag = .init()
    let viewModel: T
    
    // MARK: - Init
    init(vm: T){
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        configureVC()
        bind()
    }
    
    
    // MARK: - Helpers
    func addView(){}
    func setLayout(){}
    func configureVC(){view.backgroundColor = .white}
    func bind(){}
}
