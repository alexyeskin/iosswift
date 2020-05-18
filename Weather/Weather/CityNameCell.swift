//
//  CityNameCell.swift
//  Weather
//
//  Created by user on 08/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit

class CityNameCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTLabel: UILabel!
    @IBOutlet weak var cityBackgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCityCell(_ sender: Weather) {
        Parallax.addParallax(vw: cityBackgroundImage, magnitude: 10)
        cityNameLabel.text = sender.city
        cityTLabel.text = String(sender.t) + "°"
        self.cityBackgroundImage.image = UIImage(named: sender.description)
    }
}
