//
//  AuthTextField.swift
//  Memo
//
//  Created by baegteun on 2021/11/30.
//

import UIKit
import SnapKit

final class AuthTextField: UIView{
    // MARK: - Properties
    private let iconImageView = UIImageView()
    
    let textField = UITextField()
    
    private let underline = UIView()
    
    // MARK: - Init
    init(icon: UIImage, placeholder: String = ""){
        super.init(frame: .zero)
        iconImageView.image = icon
        textField.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setView(){
        addView()
        setLayout()
    }
}

// MARK: - UI
private extension AuthTextField{
    func addView(){
        [iconImageView, textField].forEach{ addSubview($0) }
    }
    func setLayout(){
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(self)
            $0.width.height.equalTo(42)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(iconImageView.snp.trailing)
            $0.trailing.equalTo(self)
        }
        
        underline.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.top.equalTo(textField.snp.bottom)
        }
    }
}
