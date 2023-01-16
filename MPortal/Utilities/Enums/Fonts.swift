//
//  Fonts.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

//MARK: - Fonts Enum
enum Fonts: String, CaseIterable {
    case W900 = "font_Black"
    case W800 = "font_ExtraBold"
    case W700 = "font_Bold"
    case W600 = "font_SemiBold"
    case W500 = "font_Medium"
    case EW500 = "eFont_Medium"
    case W400 = "font_Regular"
    case W300 = "font_Light"
    case RW600 = "rFont_SemiBold"
    case AW600 = "aFont_SemiBold"
    case RW700 = "rFont_Bold"
    
    var font: String {
        return self.rawValue.localized
    }
}

