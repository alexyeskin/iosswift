//
//  Alamofire.swift
//  Weather
//
//  Created by user on 26/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
