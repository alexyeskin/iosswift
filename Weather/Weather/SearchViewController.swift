//
//  SearchViewController.swift
//  Weather
//
//  Created by user on 07/04/2019.
//  Copyright © 2019 Alexander Yeskin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFoundLabel: UILabel!
    
    var matchInticator: Bool = false
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchAPI.shared.delegate = self
        SearchCity.shared.searchCities.removeAll()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.tableView.tableFooterView = UIView()
        self.searchBar.becomeFirstResponder()
        (searchBar.value(forKey: "cancelButton") as! UIButton).setTitle("Отмена", for: .normal)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchCity.shared.searchCities.removeAll()
        SearchAPI.shared.loadJSON(geocode: createRequest())
    }
    
    func createRequest() -> String {
        guard let searchBarText = searchBar.text?.replacingOccurrences(of: "\\d", with: "+", options: .regularExpression).replacingOccurrences(of: "\\W", with: " ", options: .regularExpression) else {return "0"}
        let geocodeData = searchBarText.data(using: .utf8)!
        var geocodeTextArray: [String] = []
        for value in geocodeData {
            geocodeTextArray.append("%" + String(value, radix: 16))
        }
        let geocodeTextString = geocodeTextArray.joined()
        return geocodeTextString
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchCity.shared.searchCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCell", for: indexPath) as? SearchCityCell else {
            return UITableViewCell()
        }
        cell.setSearchCell(SearchCity.shared.searchCities[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in City.shared.cities {
            if i.cityLat == SearchCity.shared.searchCityObject?.searchLat && i.cityLon == SearchCity.shared.searchCityObject?.searchLon {
                matchInticator = true
                break
            }
        }
        if matchInticator == true {
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } else {
            WeatherAPI.shared.loadJSON(lat: SearchCity.shared.searchCities[0].searchLat, lon: SearchCity.shared.searchCities[0].searchLon, cityName: SearchCity.shared.searchCities[0].searchCity)
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension SearchViewController: SearchAPIProtocol {
    func updateData() {
        self.tableView.reloadData()
    }
    func stopLoadingIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    func setFoundCondition() {
        if SearchCity.shared.isSearchCityFound == false {
            noFoundLabel.text = "Не найдено"
        }
        if SearchCity.shared.isSearchCityFound == true {
            noFoundLabel.text = ""
        }
    }
}
