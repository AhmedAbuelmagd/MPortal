//
//  Images.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 19/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

// MARK: - Images Enum
enum Images: String {

    case NONE = "onBoardingOne"
    case CHECK = "check>24#MainColor"
    
    
    var image: UIImage! {
        return UIImage(named: self.rawValue)
    }
    var tabBarImg: UIImage! {
        return UIImage(named: self.rawValue)?.withRenderingMode(.alwaysOriginal)
    }
    
}
