//
//  PropertiesModel.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 15/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

// MARK: - PropertiesModel
class PropertiesModel: Codable {
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
    var isOther: Bool?
    
    internal init(id: Int? = nil,
                  name: String? = nil,
                  description: String? = nil,
                  slug: String? = nil,
                  parent: Int? = nil,
                  categoryParentId: Int? = nil,
                  selectedOption: String? = nil,
                  selectedId: Int? = nil,
                  list: Bool? = nil,
                  type: String? = nil,
                  value: String? = nil,
                  other_value: String? = nil,
                  options: [Children]? = nil,
                  isOther: Bool? = false) {
        
        self.id = id
        self.name = name
        self.description = description
        self.slug = slug
        self.parent = parent
        self.categoryParentId = categoryParentId
        self.selectedOption = selectedOption
        self.selectedId = selectedId
        self.list = list
        self.type = type
        self.value = value
        self.other_value = other_value
        self.options = options
        self.isOther = isOther
    }
    var categoryParentIdValue: Int {
            guard let categoryParentIdValue = categoryParentId else {
                return 0
            }
            return categoryParentIdValue
        }
}

