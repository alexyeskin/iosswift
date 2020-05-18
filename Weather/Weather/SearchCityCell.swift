//
//  SearchCityCell.swift
//  Weather
//
//  Created by user on 08/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit

class SearchCityCell: UITableViewCell {
    @IBOutlet weak var searchCityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSearchCell(_ sender: SearchWeather) {
        searchCityLabel.text = sender.searchCity
    }
}
