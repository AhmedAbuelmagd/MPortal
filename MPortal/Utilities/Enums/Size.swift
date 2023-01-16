//
//  Size.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

// MARK: - Size Enum
enum Size: Int {

    case size_01 = 01
    case size_07 = 07
    case size_09 = 09
    case size_10 = 10
    case size_11 = 11
    case size_12 = 12
    case size_13 = 13
    case size_14 = 14
    case size_15 = 15
    case size_16 = 16
    case size_17 = 17
    case size_18 = 18
    case size_19 = 19
    case size_20 = 20
    case size_21 = 21
    case size_22 = 22
    case size_23 = 23
    case size_24 = 24
    case size_25 = 25
    case size_26 = 26
    case size_27 = 27
    case size_28 = 28
    case size_48 = 48
    
    var xFactor: CGFloat {
        return CGFloat(self.rawValue)*iPhoneXFactor
    }
}

