//
//  ERRORS.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
enum ERRORS: String, CaseIterable {
    case UNAUTHORIZED = "unAuthorizedError"
    case UNKNOWN = "unKnownError"
    case BAD_REQUEST = "badRequestError"
    case VIEW_MODEL_ERROR = "viewModelError"
    case CHECK_INTERNET_CONNECTION = "checkInternetConnectionError"
    
    var title: String {
         self.rawValue.localized
    }
}

