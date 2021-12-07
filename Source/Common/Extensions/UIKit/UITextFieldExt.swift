//
//  UITextFieldExt.swift
//  Memo
//
//  Created by baegteun on 2021/12/07.
//  Copyright © 2021 baegteun. All rights reserved.
//

import UIKit
import SnapKit

extension UITextField{
    func leftSpacer(size space: CGFloat){
        let spacer = UIView()
        spacer.widthAnchor.constraint(equalToConstant: space).isActive = true
        spacer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        leftView = spacer
        leftViewMode = .always
    }
}
