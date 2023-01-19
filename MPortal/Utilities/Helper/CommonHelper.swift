//
//  CommonHelper.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH
import SwiftMessages

public var screenWidth: CGFloat { get { return UIScreen.main.bounds.size.width } }
public var screenHeight:CGFloat { get { return UIScreen.main.bounds.size.height } }
public var iPhoneXFactor: CGFloat { get {return (screenWidth/360.0)} }

let appDelegate = UIApplication.shared.delegate as! AppDelegate

public var iPhoneYFactor: CGFloat { get {return ((screenHeight * 1.00) / 667.0)} }
func isEnglish() -> Bool{
 if MOLHLanguage.isRTLLanguage() { return false } else{ return true }
}
//MARK: - handle message toast
public func displayMessage(message: String, messageError: Bool) {
    
    let view = MessageView.viewFromNib(layout: .cardView)
    if messageError == true {
        view.configureTheme(.error)
        view.alpha = 0.5
    } else {
        view.configureTheme(.success)
        view.alpha = 0.8
    }
    view.titleLabel?.isHidden = true
    view.bodyLabel?.text = message
    view.titleLabel?.textColor = UIColor.white
    view.bodyLabel?.textColor = UIColor.white
    view.button?.isHidden = true
    view.bodyLabel?.font = UIFont(name: Fonts.W400.rawValue.localized, size: Size.size_13.xFactor)
    view.titleLabel?.font = UIFont(name: Fonts.W400.rawValue.localized, size: Size.size_13.xFactor)
    view.titleLabel?.textAlignment = ((isEnglish()) ? .left : .right)
    view.bodyLabel?.textAlignment = ((isEnglish()) ? .left : .right)
    view.alpha = 0.9
    var config = SwiftMessages.Config()
    config.presentationStyle = .top
    config.shouldAutorotate = true
    SwiftMessages.show(config: config, view: view)
}
public func mainQueue(_ closure: @escaping ()->()) {
    DispatchQueue.main.async(execute: closure)
}
