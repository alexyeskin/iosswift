//
//  Forecast.swift
//  Weather
//
//  Created by user on 27/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation

class Forecast {
    var forecastT: [Double]
    var forecastDescription: [String]
    
    init(forecastT: [Double], forecastDescription: [String]) {
        self.forecastT = forecastT
        self.forecastDescription = forecastDescription
    }
}
