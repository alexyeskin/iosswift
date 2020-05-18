//
//  Weather.swift
//  Weather
//
//  Created by user on 06/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation

class Weather {
    var city: String
    var t: Int
    var description: String
    var windSpeed: Int
    var windDirection: String
    var feelsT: Int
    var cityLat: String
    var cityLon: String
    
    init(city: String, t: Int, description: String, windSpeed: Int, windDirection: String, feelsT: Int, cityLat: String, cityLon: String) {
        self.city = city
        self.t = t
        self.description = description
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.feelsT = feelsT
        self.cityLat = cityLat
        self.cityLon = cityLon
    }
}
