//
//  MainViewController.swift
//  Weather
//
//  Created by user on 09/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return City.shared.cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewCell", for: indexPath) as? MainViewCell else {
            return UICollectionViewCell()
        }
        let vc = storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        cell.setCell(vc.view)
        return cell
    }
}
//cell.setCityCell(city: City.shared.cities[indexPath.row])

//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    switch indexPath.row {
//    case 0:
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
//            return UITableViewCell()
//        }
//        cell.setCell()
//        return cell
//    case 1:
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoWeatherCell", for: indexPath) as? InfoWeatherCell else {
//            return UITableViewCell()
//        }
//        cell.setInfoCell()
//        return cell
//    case 2:
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as? DayWeatherCell else {
//            return UITableViewCell()
//        }
//        cell.setDayCell()
//        return cell
//    default:
//        return UITableViewCell()
//    }
//
//}
