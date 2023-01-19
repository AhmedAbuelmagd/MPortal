//
//  UIButton+Extensions.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 17/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//
import UIKit

extension UIButton{
    
    func addUnderlineTitle(titleColor: Colors, font: Fonts = .W400, size: Size = .size_18, title: BTNs){
        let size = iPhoneXFactor*(CGFloat(size.rawValue))
        let yourAttributes: [NSAttributedString.Key: Any] = [
              .font: UIFont(name: (font.rawValue.localized), size: size)!,
              .foregroundColor: UIColor(named: titleColor.rawValue)!,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ] // .double.rawValue, .thick.rawValue
        let attributeString = NSMutableAttributedString(
            string: title.rawValue.localized,
                attributes: yourAttributes
             )
             self.setAttributedTitle(attributeString, for: .normal)
    }
    
    func custom(titleColor: Colors, font: Fonts = .W400, size: Size = .size_18, title: BTNs){
        self.setTitleColor(UIColor(named: titleColor.rawValue), for:.normal )
        let size = iPhoneXFactor*(CGFloat(size.rawValue))
        self.titleLabel?.font = UIFont(name: (font.rawValue.localized), size: size)
        self.setTitle(title.rawValue.localized, for: .normal)
    }

}

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.height / 2.0
        self.layer.cornerRadius = radius
    }
}
