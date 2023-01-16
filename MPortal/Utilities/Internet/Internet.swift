//
//  Internet.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
//import SwiftMessages
//import MOLH

class Internet {
    //MARK: - handle Connection
    class func isConnected() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
//     class func handleReachability(withRech rech: CheckConnection, fromController controller: UIViewController, withInternetCheck isConnected: Bool) {
//        NotificationCenter.default.addObserver(forName: .reachabilityChanged, object: rech, queue: .main) { (notification) in
////            if let MyRechability = notification.object as? CheckConnection {
//////                switch MyRechability.connection {
//////                case .cellular:
//////                    if isConnected {
////////                        showAlertMsg(message: "AHMED", Theme: .success, image: true)
////////                        showAlertMsg(message: "connected", Theme: .success, image: false)
//////                    }else{
//////
//////                    }
//////                case .wifi:
//////                    if isConnected{
////////                        showAlertMsg(message: "AHMED", Theme: .success, image: true)
//////                        showAlertMsg(message: "connected", Theme: .success, image: false)
//////                    }else{
//////                        showAlertMsg(message: "not connected", Theme: .success, image: false)
//////                    }
//////                case .none:
//////                    showAlertMsg(message: "connected", Theme: .success, image: false)
//////                }
////            }
//        }
//    }
}

