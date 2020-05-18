//
//  mainViewCell.swift
//  Weather
//
//  Created by user on 10/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit
import Charts

class ViewCell: UICollectionViewCell {
    @IBOutlet weak var cellBackGroundImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tLabel: UILabel!
    @IBOutlet weak var discripionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDiractionLabel: UILabel!
    @IBOutlet weak var FeelsTLabel: UILabel!
    @IBOutlet var daysLabels: [UILabel]!
    @IBOutlet var discriptionDaysLabels: [UILabel]!
    @IBOutlet var tDaysLabels: [UILabel]!
    @IBOutlet weak var lineChartView: LineChartView!
    var daysOfWeek: [String] = []
    
    override func awakeFromNib()
    {
        self.contentView.autoresizingMask.insert(.flexibleHeight)
        self.contentView.autoresizingMask.insert(.flexibleWidth)
    }
    
    func setSelectedCity(_ sender: Weather) {
        guard let dayOfWeak = Date().dayNumberOfWeek() else {return}
        daysOfWeek = ForecastCell.setDayOfWeek(dayOfWeak: dayOfWeak)
        Parallax.addParallax(vw: cellBackGroundImage, magnitude: 5)
        self.cityLabel.text = sender.city
        self.tLabel.text = String(sender.t) + "°"
        self.discripionLabel.text = ForecastCell.setDiscriptionWeather(codeDiscription: sender.description)
        self.cellBackGroundImage.image = UIImage(named: sender.description)
        self.windSpeedLabel.text = "Скорость ветра: " + String(sender.windSpeed) + " м/с"
        self.windDiractionLabel.text = "Направление ветра: " + sender.windDirection
        self.FeelsTLabel.text = "Ощущается как: " + String(sender.feelsT) + "°"
        for i in 0 ..< daysLabels.count {
            daysLabels[i].text = String(daysOfWeek[i])
        }
    }
    
    func setForecast(_ sender: Forecast) {
        for i in 0 ..< discriptionDaysLabels.count {
            discriptionDaysLabels[i].text = ForecastCell.setDiscriptionWeather(codeDiscription: sender.forecastDescription[i])
        }
        for i in 0 ..< tDaysLabels.count {
            tDaysLabels[i].text = String(Int(sender.forecastT[i])) + "°"
        }
        ForecastCell.setChart(lineChartView: lineChartView, values: sender.forecastT)
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

