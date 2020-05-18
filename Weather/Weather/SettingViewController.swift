//
//  SettingViewController.swift
//  Weather
//
//  Created by user on 05/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func scrollToItem(indexPath: IndexPath)
}

class SettingViewController: UIViewController {
    @IBOutlet weak var addNewCityButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: SettingViewControllerDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherAPI.shared.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewCityButtonPressed(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            return
        }
        present(vc, animated: true, completion: nil)
    }
}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return City.shared.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityNameCell", for: indexPath) as? CityNameCell else {
            return UITableViewCell()
        }
        cell.setCityCell(City.shared.cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.scrollToItem(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.row != 0 {
                City.shared.cities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
    }
}
extension SettingViewController: WeatherAPIProtocol {
    func updateData() {
        self.tableView.reloadData()
    }
    
    func stopLoadingIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func stopUpdatingLocation() {}
}
