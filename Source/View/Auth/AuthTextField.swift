//
//  AuthTextField.swift
//  Memo
//
//  Created by baegteun on 2021/11/30.
//

import UIKit
import SnapKit

final class AuthTextField: UITextField{
    // MARK: - Properties
    private let iconImageView = UIImageView()
    
    
    private let underline = UIView().then {
        $0.backgroundColor = .black
    }
    
    // MARK: - Init
    init(icon: UIImage, placeholder: String = ""){
        super.init(frame: .zero)
        iconImageView.image = icon
        self.placeholder = placeholder
        addView()
        setLayout()
        leftSpacer(size: 30)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
private extension AuthTextField{
    func addView(){
        [iconImageView, underline].forEach{ addSubview($0) }
    }
    func setLayout(){
        iconImageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.height.width.equalTo(28)
        }
        underline.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.snp.bottom).offset(3)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
    }
    func configure(){
        font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: UIFont(name: "TrebuchetMS", size: 20) ?? .init(), maximumPointSize: 20)
    }
}
