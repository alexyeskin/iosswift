//
//  City.swift
//  Weather
//
//  Created by user on 09/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation

class City {
    static let shared = City()
    var cities: [Weather] = []
    var cityObject: Weather!
    
    let defaults = UserDefaults.standard
    
    func saveCities() {
        defaults.set(City.shared.cities.count, forKey: "CitiesCount")
        for index in 0..<City.shared.cities.count {
            defaults.set(stringOfWeatherObject(index: index), forKey: "City" + String(index))
        }
    }
    
    func loadCities() {
        let cityCount = defaults.integer(forKey: "CitiesCount")
        for index in 0..<cityCount {
            guard let defaultsString = defaults.string(forKey: "City" + String(index)) else {return}
            let cityWeatherDates: [Substring] = (defaultsString.split(separator: "_"))
            WeatherAPI.shared.loadJSON(lat: String(cityWeatherDates[0]), lon: String(cityWeatherDates[1]), cityName: String(cityWeatherDates[2]))
        }
    }
    
    func stringOfWeatherObject (index: Int) -> String {
        let stringOfWeatherObject = String(City.shared.cities[index].cityLat + "_" + City.shared.cities[index].cityLon + "_" + City.shared.cities[index].city)
        return stringOfWeatherObject
    }
}
