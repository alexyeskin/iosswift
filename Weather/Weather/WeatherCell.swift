//
//  WeatherCell.swift
//  Weather
//
//  Created by user on 05/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit
import Foundation

class WeatherCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tLabel: UILabel!
    @IBOutlet weak var weatherLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell() {
        cityLabel.text = "Minsk"
        tLabel.text = "15" + "°"
        weatherLabel.image = UIImage(named: "sun_icon")
    }

}
