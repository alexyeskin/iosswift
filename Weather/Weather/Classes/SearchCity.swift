//
//  SearchCity.swift
//  Weather
//
//  Created by user on 27/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation

class SearchCity {
    static let shared = SearchCity()
    var searchCities: [SearchWeather] = []
    var searchCityObject: SearchWeather!
    var isSearchCityFound: Bool?
}
