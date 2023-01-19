//
//  UIView+Extensions.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH


extension UIView{
    func circleCornerRadius(){
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
    }
    
    func addShadow(scale: Bool = true) {
        //shadow
        layer.shadowRadius = 1
        layer.shadowColor = UIColor(hexString: Colors.C707070.rawValue).cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        layer.masksToBounds = false
        layer.cornerRadius = 8
        //        self.clipsToBounds = true
        layer.masksToBounds = false
    }
    
    func addRadius(radius : CGFloat) {
        self.layer.cornerRadius = radius*iPhoneXFactor
    }
    func addCornerRadiusWithBoard(radius: CGFloat, borderColor: Colors = .C7B8497, borderWidth: CGFloat = 1) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor(hexString: borderColor.rawValue).cgColor
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    func addBorder(borderColor : Colors = .C7B8497, borderWidth : CGFloat = 1) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor(hexString: borderColor.rawValue).cgColor
    }
    func addCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
    }
}

