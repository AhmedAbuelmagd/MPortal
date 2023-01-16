//
//  Categories.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

struct Categories: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var image: String?
    
    var slug: String?
    var children: [Children]?
    var circle_icon: String?
    var disable_shipping: Int?
    var isSelected: Bool?
}
