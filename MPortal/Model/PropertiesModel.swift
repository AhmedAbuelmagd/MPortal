//
//  PropertiesModel.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

// MARK: - PropertiesModel
struct PropertiesModel: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var slug: String?
    var parent: Int?
    var categoryParentId: Int?
    var selectedOption: String?
    var selectedId: Int?
    var list: Bool?
    var type: String?
    var value: String?
    var other_value: String?
    var options: [Children]?
}

