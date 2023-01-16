//
//  Options.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
struct Options: Codable {
    var id: Int?
    var name: String?
    var slug: String?
    var parent: Int?
    var child: Bool?
    var isSelected: Bool?

}

