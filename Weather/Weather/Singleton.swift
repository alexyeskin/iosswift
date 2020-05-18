//
//  Singleton.swift
//  Weather
//
//  Created by user on 09/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation
import UIKit

class Settings {
    static let shared = Settings()
    
    var colorStyle = UIColor.white
    var volumeLevel: Float = 1.0
    
    private init() {}
}
