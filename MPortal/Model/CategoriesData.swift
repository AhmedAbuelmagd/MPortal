//
//  CategoriesData.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

struct CategoriesData: Codable {
    var categories: [Categories]?
    var statistics: Statistics?
    var ads_banners: [Ads_banners]?
    var ios_version: String?
    var google_version: String?
    var huawei_version: String?
}
