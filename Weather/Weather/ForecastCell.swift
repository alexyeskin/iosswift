//
//  ForecastCell.swift
//  Weather
//
//  Created by user on 23/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ForecastCell {
    static func setDiscriptionWeather(codeDiscription: String) -> String {
        switch codeDiscription {
        case "01d":
            return "☀️"
        case "01n":
            return "🌙"
        case "02d", "02n":
            return "🌤"
        case "03d", "03n":
            return "☁️"
        case "04d", "04n":
            return "🌥"
        case "09d", "09n":
            return "🌦"
        case "10d", "10n":
            return "🌧"
        case "11d", "11n":
            return "🌩"
        case "13d", "13n":
            return "❄️"
        case "50d", "50n":
            return "🌫"
        default:
            return "☀️"
        }
    }
    static func setChart(lineChartView: LineChartView, values: [Double]) {
            var lineChartEntry = [ChartDataEntry]()
            func setChart(values: [Double]) {
                for i in 0 ..< values.count {
                    let value = ChartDataEntry(x: Double(i), y: values[i])
                    lineChartEntry.append(value)
                }
                let line1 = LineChartDataSet(entries: lineChartEntry, label: "temp")
                let data = LineChartData()
                chartSettings(lineChartView: lineChartView, line1: line1)
                data.addDataSet(line1)
                lineChartView.data = data
            }
            setChart(values: values)
    }
    
    static private func chartSettings(lineChartView: LineChartView, line1: LineChartDataSet) {
        axisSettings(lineChartView: lineChartView)
        xAxisSettings(lineChartView: lineChartView)
        lineChartViewSettings(lineChartView: lineChartView)
        lineSetting(line1: line1)
    }
    
    static private func xAxisSettings(lineChartView: LineChartView) {
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.xAxis.drawLabelsEnabled = false
    }
    
    static private func axisSettings(lineChartView: LineChartView) {
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.labelTextColor = UIColor.white
    }
    
    static private func lineChartViewSettings(lineChartView: LineChartView) {
        lineChartView.setScaleEnabled(false)
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.legend.enabled = false
        lineChartView.dragEnabled = true
        lineChartView.highlightPerTapEnabled = false
        lineChartView.highlightPerDragEnabled = false
    }
    
    static private func lineSetting(line1: LineChartDataSet) {
        line1.colors = [NSUIColor.cyan]
        line1.drawCircleHoleEnabled = false
        line1.valueTextColor = UIColor.white
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = false
        line1.drawFilledEnabled = true
        line1.fillColor = UIColor.white
        line1.fillAlpha = 0.15
        line1.mode = .cubicBezier
    }

    
    
    static func setDayOfWeek (dayOfWeak: Int) -> [String] {
        var daysOfWeek: [String] = []
        switch dayOfWeak {
        case 1:
            daysOfWeek += ["Пн.", "Вт.", "Ср.", "Чт.", "Пт."]
        case 2:
            daysOfWeek += ["Вт.", "Ср.", "Чт.", "Пт.", "Сб."]
        case 3:
            daysOfWeek += ["Ср.", "Чт.", "Пт.", "Сб.", "Вс."]
        case 4:
            daysOfWeek += ["Чт.", "Пт.", "Сб.", "Вс.", "Пн."]
        case 5:
            daysOfWeek += ["Пт.", "Сб.", "Вс.", "Пн.", "Вт."]
        case 6:
            daysOfWeek += ["Сб.", "Вс.", "Пн.", "Вт.", "Ср."]
        case 7:
            daysOfWeek += ["Вс.", "Пн.", "Вт.", "Ср.", "Чт."]
        default:
            daysOfWeek += ["Пн.", "Вт.", "Ср.", "Чт.", "Пт."]
        }
        return daysOfWeek
    }
}
