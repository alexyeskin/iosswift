//
//  CityForecast.swift
//  Weather
//
//  Created by user on 27/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation

class CityForecast {
    static let shared = CityForecast()
    var forecasts: [Forecast] = []
    
    func createForecast(forecastT: [Double], forecastDescription: [String]) {
        forecasts.append(Forecast(forecastT: forecastT, forecastDescription: forecastDescription))
    }
}
