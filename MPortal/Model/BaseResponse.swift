//
//  BaseResponse.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
struct BaseResponse<E : Codable> : Codable {
    var code: Int?
    var msg: String?
    var data: E?
    var error: E?
}
