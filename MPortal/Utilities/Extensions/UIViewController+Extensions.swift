//
//  UIViewController+Extensions.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 16/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH
import JGProgressHUD


private let loaderJG = JGProgressHUD(style: .light)

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismisKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismisKeyboard() {
        view.endEditing(true)
    }
    
    func showLoader(){
        loaderJG.show(in: self.view, animated: true)
    }
    
    func hideLoader(){
        loaderJG.dismiss(animated: true)
    }
    
    func dismiss(){
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
