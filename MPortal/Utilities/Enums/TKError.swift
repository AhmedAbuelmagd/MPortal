//
//  TKError.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

//// MARK: - TKError
enum TKError: Int, Error {
    case unAuthorized = 401
    case badRequest = 400
    case notFound = 404
    case apiError = 500
    case notHandleStatusCode = 0
}

extension TKError {
    func getErrorMessage() -> String? {
        switch self {
        case .unAuthorized: return ERRORS.UNAUTHORIZED.rawValue.localized
        case .notFound: return ERRORS.UNKNOWN.rawValue.localized
        case .badRequest: return ERRORS.BAD_REQUEST.rawValue.localized
        case .apiError: return ERRORS.UNKNOWN.rawValue.localized
        case .notHandleStatusCode: return ERRORS.UNKNOWN.rawValue.localized
        }
    }
}
