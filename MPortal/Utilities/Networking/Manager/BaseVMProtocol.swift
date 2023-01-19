//
//  BaseVMProtocol.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation

protocol BaseVMProtocol {
    var showLoading: Bindable<Bool> { get set }
    var onShowError: ((_ alert: String) -> Void)?  { get set }
    var onShowSuccess: ((_ alert: String) -> Void)?  { get set }
}
