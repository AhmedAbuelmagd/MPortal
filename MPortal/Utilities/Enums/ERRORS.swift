//
//  ERRORS.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
enum ERRORS: String, CaseIterable {
    
//    case PHONE_NOT_VALID = "phoneNotValidError"
//    case EMPTY_EMAIL = "emptyEmailError"
//    case EMAIL_NOT_VALID = "emailNotValidError"
//    case EMPTY_PHONE = "emptyPhoneError"
//    case EMPTY_PASSWORD = "emptyPasswordError"
//    case EMPTY_C_PASSWORD = "emptyCPasswordError"
//    case PASSWORDS_NOT_EQUAL = "passwordsNotEqualError"
//    case PASSWORD_COUNT = "passwordCountError"
//    case EMAIL_EXIST = "emailExistError"
//    case EMPTY_NAME = "emptyNameError"
//    case EMPTY_DAY = "emptyDayError"
//    case EMPTY_MONTH = "emptyMonthError"
//    case EMPTY_YEAR = "emptyYearError"
//    case EMPTY_GENDER = "emptyGender"
    case UNAUTHORIZED = "unAuthorizedError"
    case UNKNOWN = "unKnownError"
    case BAD_REQUEST = "badRequestError"
//    case BASE_URL_ERROR = "baseURLError"
    case VIEW_MODEL_ERROR = "viewModelError"
    case CHECK_INTERNET_CONNECTION = "checkInternetConnectionError"
//    case FILL_VERIFICATION_CODE = "fillVerificationCodeError"
    
    var title: String {
         self.rawValue.localized
    }
}

