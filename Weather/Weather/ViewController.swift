//
//  ViewController.swift
//  Weather
//
//  Created by user on 05/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import Charts
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    let locationManager = CLLocationManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherAPI.shared.delegate = self
        setupNavigationBar()
        self.collectionView.bounces = false
        if CLLocationManager.locationServicesEnabled() {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            self.present(Alerts.showUnableLocation(), animated: true, completion: nil)
        }
        if Connectivity.isConnectedToInternet() {
        } else {
            self.present(Alerts.showUnableInternetConnection(), animated: true, completion: nil)
        }
        collectionView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            WeatherAPI.shared.loadJSON(lat: "\(location.coordinate.latitude)", lon: "\(location.coordinate.longitude)", cityName: "GeoCityName")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.present(Alerts.showUnableLocation(), animated: true, completion: nil)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else {
            return
        }
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return City.shared.cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCell", for: indexPath) as? ViewCell else {
            return UICollectionViewCell()
        }
        cell.setSelectedCity(City.shared.cities[indexPath.row])
        cell.setForecast(CityForecast.shared.forecasts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
extension ViewController: SettingViewControllerDelegate {
    func scrollToItem(indexPath: IndexPath) {
        self.collectionView.reloadData()
        self.collectionView.scrollToItem(at: indexPath, at: .init(rawValue: 0), animated: true)
    }
}
extension ViewController: WeatherAPIProtocol {
    func updateData() {
        self.collectionView.reloadData()
    }
    
    func stopLoadingIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

}
