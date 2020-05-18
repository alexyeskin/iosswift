//
//  Alerts.swift
//  Weather
//
//  Created by user on 26/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import Foundation
import UIKit

class Alerts {
    static func showUnableInternetConnection() -> UIAlertController {
        let alertController = UIAlertController(title: "Ошибка", message: "Интернет соединение недоступно", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel) { (action) in }
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        let reloadAction = UIAlertAction(title: "Перезагрузить", style: .default) { (_) -> Void in
            City.shared.loadCities()
        }
        alertController.addAction(settingsAction)
        alertController.addAction(action)
        alertController.addAction(reloadAction)
        return alertController
    }
    
    static func showUnableLocation() -> UIAlertController {
        let alertController = UIAlertController(title: "Ошибка", message: "Геолокация недоступна", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel) { (action) in }
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        alertController.addAction(settingsAction)
        alertController.addAction(action)
        return alertController
    }
}
