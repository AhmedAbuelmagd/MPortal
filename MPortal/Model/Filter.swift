//
//  Filter.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

// MARK: - Filter
struct Filter: Codable {
    var id: Int?
    var name: String?
    var title: String?
    var image: String?
    var placeholder: String?
}
