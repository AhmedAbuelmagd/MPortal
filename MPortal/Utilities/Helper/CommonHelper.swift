//
//  CommonHelper.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH

public var screenWidth: CGFloat { get { return UIScreen.main.bounds.size.width } }
public var screenHeight:CGFloat { get { return UIScreen.main.bounds.size.height } }
public var iPhoneXFactor: CGFloat { get {return ((screenWidth * 1.00) / 360.0)} }

let appDelegate = UIApplication.shared.delegate as! AppDelegate

public var iPhoneYFactor: CGFloat { get {return ((screenHeight * 1.00) / 667.0)} }
func isEnglish() -> Bool{
 if MOLHLanguage.isRTLLanguage() { return false } else{ return true }
}
