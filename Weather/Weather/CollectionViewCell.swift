//
//  CollectionViewCell.swift
//  Weather
//
//  Created by user on 07/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tDayImage: UIImageView!
    @IBOutlet weak var tDayLabel: UILabel!
    
    func setCollectionCell() {
        dayLabel.text = "Mon."
        tDayImage.image = UIImage(named: "sun_icon")
        tDayLabel.text = "15" + "°"
    }
}
