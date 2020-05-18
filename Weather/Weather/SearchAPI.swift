//
//  SearchAPI.swift
//  Weather
//
//  Created by user on 15/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation
import UIKit

protocol SearchAPIProtocol: AnyObject {
    func updateData()
    func stopLoadingIndicator()
    func setFoundCondition()
}

class SearchAPI {
    static let shared = SearchAPI()
    weak var delegate: SearchAPIProtocol?
    var searchURL = "https://geocode-maps.yandex.ru/1.x/"
    var searchApiKey = "b9a1ab9d-c60a-44ef-b17c-65ff74c3bdd0"
    var lat: String?
    var lon: String?
 
    func loadJSON(geocode: String) {
        guard let url = URL(string: "\(searchURL)?apikey=\(searchApiKey)&format=json&geocode=\(geocode)&language=ru_RU") else {
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let session = URLSession.shared
        session.dataTask(with: url) { (data, responce, error) in
            if data != nil {
                guard let data = data else {
                    print("Error: No JSON data")
                    return
                }
                guard let JSONData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                self.parseJSON(JSONData: JSONData)
                self.parseJSONWithZeroFound(JSONData: JSONData)
            } else {
                print("Error: API")
            }
            }.resume()
    }
    
    func parseJSON(JSONData: [String: Any]?) {
        guard let response = JSONData?["response"] as? [String: Any] else {return}
        guard let GeoObjectCollection = response["GeoObjectCollection"] as? [String: Any] else {return}
        guard let featureMember = GeoObjectCollection["featureMember"] as? [Any] else {return}
        if featureMember.count == 0 {return}
        guard let EnterGeoObject = featureMember[0] as? [String: Any] else {return}
        guard let geoОbject = EnterGeoObject["GeoObject"] as? [String: Any] else {return}
        guard let Point = geoОbject["Point"] as? [String: Any] else {return}
        guard let cityPos = Point["pos"] as? String else {return}
        guard let cityName = geoОbject["name"] as? String else {return}
        let cityCoordinates = cityPos.components(separatedBy: " ")
        let lat = cityCoordinates[1]
        let lon = cityCoordinates[0]
        print(lat, lon)
        SearchCity.shared.searchCityObject = SearchWeather(searchCity: cityName, searchLat: lat, searchLon: lon)
        SearchCity.shared.searchCities.append(SearchCity.shared.searchCityObject)
        
        DispatchQueue.main.async {
            self.delegate?.updateData()
            self.delegate?.stopLoadingIndicator()
        }
    }
    func parseJSONWithZeroFound(JSONData: [String: Any]?) {
        guard let response = JSONData?["response"] as? [String: Any] else {return}
        guard let GeoObjectCollection = response["GeoObjectCollection"] as? [String: Any] else {return}
        guard let metaDataProperty = GeoObjectCollection["metaDataProperty"] as? [String: Any] else {return}
        guard let GeocoderResponseMetaData = metaDataProperty["GeocoderResponseMetaData"] as? [String: Any] else {return}
        guard let found = GeocoderResponseMetaData["found"] as? String else {return}
        
        if found == "0" {
            SearchCity.shared.isSearchCityFound = false
        } else {
            SearchCity.shared.isSearchCityFound = true
        }
        
        DispatchQueue.main.async {
            self.delegate?.updateData()
            self.delegate?.stopLoadingIndicator()
            self.delegate?.setFoundCondition()
        }
    }
}
