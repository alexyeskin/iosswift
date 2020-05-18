//
//  SearchCity.swift
//  Weather
//
//  Created by user on 27/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation

class SearchWeather {
    var searchCity: String
    var searchLat: String
    var searchLon: String
    
    init(searchCity: String, searchLat: String, searchLon: String) {
        self.searchCity = searchCity
        self.searchLat = searchLat
        self.searchLon = searchLon
    }
}
