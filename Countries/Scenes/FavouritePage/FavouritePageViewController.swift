//
//  FavouritePageViewController.swift
//  Countries
//
//  Created by Enes Aydogdu on 22.06.2022.
//

import Foundation
import UIKit

class FavouritePageViewController: UIViewController {
    
    @IBOutlet weak var savedCountriesTableView: UITableView?
    
    var savedCountriesList: [FavouriteCountriesModel] = [] {
        didSet {
            savedCountriesTableView?.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveSavedCountries()
    }
    
    private func configureTableView() {
        savedCountriesTableView?.separatorStyle = .none
    }
    
    private func retrieveSavedCountries() {
        if let data = UserDefaults.standard.value(forKey:"favouriteCountries") as? Data {
            let favouriteCountries = try? PropertyListDecoder().decode(Array<FavouriteCountriesModel>.self, from: data)
            savedCountriesList = favouriteCountries ?? []
        }
    }
    
}

extension FavouritePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCountriesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteListTableViewCell", for: indexPath) as! FavouriteListTableViewCell
        cell.savedCountryName?.text = savedCountriesList[indexPath.row].countryName
        cell.indexPath = indexPath.row
        cell.completion = {
            self.savedCountriesList.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.savedCountriesList), forKey:"favouriteCountries")            
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsPageViewController") as? DetailsPageViewController {
            detailsViewController.countryCodeText = savedCountriesList[indexPath.row].countryCode
            detailsViewController.isCountrySaved = true
            detailsViewController.indexOfCountry = indexPath.row
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
