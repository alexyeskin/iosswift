//
//  API.swift
//  Weather
//
//  Created by user on 09/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.


import Foundation
import UIKit

protocol WeatherAPIProtocol: AnyObject {
    func updateData()
    func stopLoadingIndicator()
    func stopUpdatingLocation()
}

class WeatherAPI {
    static let shared = WeatherAPI()
    weak var delegate: WeatherAPIProtocol?
    var weatherURL = "https://api.openweathermap.org/data/2.5/"
    var APIKey = "9b3be2f2d86aa88f89de13745272a15e"

    func loadJSON(lat: String, lon: String, cityName: String) {
        guard let url = URL(string: "\(weatherURL)forecast?lat=\(lat)&lon=\(lon)&appid=\(APIKey)&units=metric") else {
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
                self.parseJSON(JSONData: JSONData, cityName: cityName, lat: lat, lon: lon)
                self.weatherForecast(JSONData: JSONData)
            } else {
                print("Error: API")
            }
            }.resume()
    }

    func parseJSON(JSONData: [String: Any]?, cityName: String, lat: String, lon: String) {
        guard let city = JSONData?["city"] as? [String: Any] else {return}
        guard let nameCity = city["name"] as? String else {return}
        guard let weather = JSONData?["list"] as? [Any] else {return}
        guard let currentWeather = weather[0] as? [String: Any] else {return}
        guard let weatherValue = currentWeather["main"] as? [String: Any] else {return}
        guard let currentTDouble = weatherValue["temp"] as? Double else {return}
        let currentT = Int(currentTDouble)
        guard let weatherType = currentWeather["weather"] as? [Any] else {return}
        guard let enterWeather = weatherType[0] as? [String: Any] else {return}
        guard let currentWeatherDescription = enterWeather["icon"] as? String else {return}
        guard let wind = currentWeather["wind"] as? [String: Any] else {return}
        guard let currectWindSpeed = wind["speed"] as? Double else {return}
        guard let currectWindDirection = wind["deg"] as? Double else {return}
        guard let currentHumidity = weatherValue["humidity"] as? Int else {return}
        
        switch cityName {
        case "GeoCityName":
            City.shared.cityObject = Weather(city: nameCity, t: currentT, description: currentWeatherDescription, windSpeed: Int(currectWindSpeed), windDirection: convertDegree(currectWindDirection: currectWindDirection), feelsT: feelsLikeT(currentT: currentT, currentHumidity: currentHumidity, currectWindSpeed: currectWindSpeed), cityLat: lat, cityLon: lon)
            if !City.shared.cities.isEmpty && City.shared.cities[0].city == City.shared.cityObject?.city {
                City.shared.cities.remove(at: 0)
            }
            City.shared.cities.insert(City.shared.cityObject, at: 0)
        default:
            City.shared.cityObject = Weather(city: cityName, t: currentT, description: currentWeatherDescription, windSpeed: Int(currectWindSpeed), windDirection: convertDegree(currectWindDirection: currectWindDirection), feelsT: feelsLikeT(currentT: currentT, currentHumidity: currentHumidity, currectWindSpeed: currectWindSpeed), cityLat: lat, cityLon: lon)
            City.shared.cities.append(City.shared.cityObject)
        }
        
        DispatchQueue.main.async {
            self.delegate?.updateData()
            self.delegate?.stopLoadingIndicator()
            self.delegate?.stopUpdatingLocation()
        }
    }
    
    func weatherForecast(JSONData: [String: Any]?) {
        let startOfToday = Int(Calendar.current.startOfDay(for: Date()).timeIntervalSince1970)
        let dayInTimeUnix = 12*60*60
        guard let weatherForecast = JSONData?["list"] as? [Any] else {return}
        let listCount = weatherForecast.count
        var tempArray = [Double]()
        var averageTemperatureArray = [Double]()
        var imagesContainer = [String]()
        var weatherImages = [String]()
        for day in 1...5 {
            let startDay = startOfToday+(dayInTimeUnix)*day
            let endOfDay = startDay+dayInTimeUnix+dayInTimeUnix*day
            for arrIndex in 0..<listCount {
                let list = weatherForecast[arrIndex] as? [String: Any]
                let dt = list?["dt"] as! Int
                let sys = list?["sys"] as? [String: Any]
                guard let dayIndex = sys?["pod"] as? String else {return}
                if dt >= startDay && dt <= endOfDay && dayIndex == "d" {
                    let weather = list?["weather"] as? [Any]
                    let weatherArray = weather?[0] as? [String: Any]
                    guard let icon = weatherArray?["icon"] as? String else {return}
                    let main = list?["main"] as? [String: Any]
                    guard let forecastTempDouble = main?["temp"] as? Double else {return}
                    tempArray.append(forecastTempDouble)
                    imagesContainer.append(icon)
                }
            }
            var temp = 0.0
            for temperature in tempArray {
                temp += temperature
            }
            let tempArrayCount = Double(tempArray.count)
            let averageTempDouble = temp/tempArrayCount
            averageTemperatureArray.append(averageTempDouble)
            tempArray.removeAll()
            weatherImages.append(imagesContainer[0])
            imagesContainer.removeAll()
        }
        CityForecast.shared.createForecast(forecastT: averageTemperatureArray, forecastDescription: weatherImages)
    }

    func feelsLikeT(currentT: Int, currentHumidity: Int, currectWindSpeed: Double) -> Int {
        let currentT2 = pow(Double(currentT), 2.0)
        let currentHumidity2 = pow(Double(currentHumidity), 2.0)
        let currectWindSpeed016 = pow(Double(currectWindSpeed), 0.16)
        switch currentT {
        case ...27:
            return Int(13.12 + 0.6215 * Double(currentT) - 11.37 * currectWindSpeed016 + 0.3965 * Double(currentT) * currectWindSpeed016)
        case 27...:
            return Int((-8.78469475556) + (1.61139411 * Double(currentT)) + (2.33854883889 * Double(currentHumidity)) + (-0.14611605 * Double(currentT) * Double(currentHumidity)) + (-0.012308094 * Double(currentT2)) + (-0.0164248277778 * Double(currentHumidity2)) + (0.002211732 * Double(currentT2) * Double(currentHumidity)) + (0.00072546 * Double(currentT) * Double(currentHumidity2)) + (-0.000003582 * Double(currentT2) * Double(currentHumidity2)))
        default:
            return currentT
        }
    }
    
    func convertDegree(currectWindDirection: Double) -> String {
        let directions = ["С", "ССВ", "СВ", "ВВС", "В", "ВЮВ", "ЮВ", "ЮЮВ", "Ю", "ЮЮЗ", "ЮЗ", "ЗЮЗ", "З", "ЗСЗ", "СЗ", "ССЗ"]
        let index = Int((currectWindDirection + 11.25) / 22.5) & 15
        return directions[index]
    }
}
