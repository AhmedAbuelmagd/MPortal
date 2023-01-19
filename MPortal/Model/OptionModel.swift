//
//  OptionModel.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 16/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

struct OptionModel: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var slug: String?
    var parent: Int?
    var list: Bool?
    var type: String?
    var value: String?
    var other_value: String?
    var options: [Children]?
}

