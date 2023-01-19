//
//  ErrorModel.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

struct ErrorModel: Codable, LocalizedError {
    var message: String?
    var errorDescription: String?{
        return message ?? ""
    }
}

