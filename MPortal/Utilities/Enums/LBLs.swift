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
//    case AUCTION_CURRENT_PRICE = "auctionCurrentPriceLbl"
    case SELLER = "sellerLbl"
    case SELLER_NAME = "sellerNameLbl"
    case PRODUCTS_NUM = "productsNumbersLbl"
    case BIDDER_NAME = "bidderNameLbl"
    case SHOW_ALL = "showAllLbl"
    case BIDDERS = "biddersLbl"
    case SIMILAR_PRODUCTS = "similarProductsLbl"
    case PRODUCT_DESCRIPTION = "productDescriptionLbl"
    case RIYAL = "riyalLbl"
    case START_AFTER = "startAfterLbl"
    case AUCTION_START = "auctionStartLbl"
    case DAY = "dayLbl"
    case Hour = "hourLbl"
    case MINUTE = "minuteLbl"
    case lIVE_AUCTION = "liveAuctionLbl"
    case AUCTION_NAME = "auctionNameLbl"
    case AUCTION_DETAILS = "auctionDetailsLbl"
    case AUCTION_RATE = "auctionRateLbl"
    case AUCTION_CURRENT_PRICE = "auctionCurrentPriceLbl"
    case AUCTION_CURRENT_PRICE_TAX = "auctionCurrentPriceTaxLbl"
    
    
    case AUCTION_DATE = "auctionDateLbl"
    case AUCTION_START_AFTER = "auctionStartAfterLbl"
    
    case FULL_HOUR = "fullHourLbl"
    case FULL_MINUTE = "fullMinuteLbl"
    case AUCTION_PRICE_NOW = "auctionPriceNowLbl"
    
    var title: String {
         self.rawValue.localized
    }
}
