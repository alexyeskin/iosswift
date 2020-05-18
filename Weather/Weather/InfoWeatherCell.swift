//
//  InfoWeatherCell.swift
//  Weather
//
//  Created by user on 06/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit
import Foundation

class InfoWeatherCell: UITableViewCell {
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDiractionLabel: UILabel!
    @IBOutlet weak var FeelsTLabel: UILabel!
    
    var windSpeedLabelText = "Speed of wind: "
    var windDiractionLabelText = "Diraction of wind: "
    var FeelsTLabelText = "Feels like: "
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setInfoCell() {
        windSpeedLabel.text = windSpeedLabelText + "3" + " m/s"
        windDiractionLabel.text = windDiractionLabelText + "ESE"
        FeelsTLabel.text = FeelsTLabelText + "12" + "°"
    }
    

}

//windSpeedLabel.text = windSpeedLabelText + String(weather.windSpeed)  + " m/s"
//windDiractionLabel.text = windDiractionLabelText + weather.windDirection
//FeelsTLabel.text = FeelsTLabelText + String(weather.feelsT) + "°"
