//
//  Lbls.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 17/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

// MARK: - LBLs Enum
enum LBLs: String {
    case SELECT = "selectLbl"
    case CATEGORY = "categoryLbl"
    case SUB_CATEGORY = "subcategoryLbl"
    case SEARCH = "searchLbl"
    case MAIN_CATEGORY_FIRST = "mainCategoryFirstLbl"
    case OTHER = "otherLbl"
    case SELECT_YOUR_LANG = "selectYourLangLbl"
    case LANG_NOTE = "langNoteLbl"
    case AUCTION_CURRENT_PRICE = "auctionCurrentPriceLbl"
    var title: String {
         self.rawValue.localized
    }
}
