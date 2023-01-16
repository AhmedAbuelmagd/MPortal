//
//  UILabel+Extension.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

extension UILabel {
    
    func customLabel(color: Colors, size: Size, font: Fonts, text: String = "", direction: Direction = .Normal, nOlines: Int = 1) {
        
        let size = iPhoneXFactor*(CGFloat(size.rawValue))
        self.font = UIFont(name: font.font, size: size)
        
        switch direction {
        case .Left: self.textAlignment = ((isEnglish()) ? .left : .left)
        case .Right: self.textAlignment = ((isEnglish()) ? .right : .right)
        case .Normal: self.textAlignment = ((isEnglish()) ? .left : .right)
        case .Center: self.textAlignment = .center
            
        }
        
        self.textColor = UIColor(hexString: color.rawValue)
        self.text = text
    }

}
