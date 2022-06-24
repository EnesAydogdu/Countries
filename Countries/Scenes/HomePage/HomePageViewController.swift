//
//  HomePageViewController.swift
//  Countries
//
//  Created by Enes Aydogdu on 22.06.2022.
//

import Foundation
import UIKit

class HomePageViewController: UIViewController {
    
    private var countryList: CountryListResponseModel?
    var savedCountriesList: [FavouriteCountriesModel] = [] {
        didSet {
            countryListTableView?.reloadData()
        }
    }
    @IBOutlet weak var countryListTableView: UITableView!
    var isCountrySaved: Bool = false
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveCountryList()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveSavedCountries()
    }
    
    private func configureTableView() {
        countryListTableView.separatorStyle = .none
        countryListTableView.estimatedRowHeight = 300;
    }
    
    private func retrieveCountryList() {
        NetworkService.shared.fetchCountryList { [weak self] response in
            self?.countryList = response
            DispatchQueue.main.async {
                self?.countryListTableView.reloadData()
            }
        }
    }
    private func checkIfCountryWillSaved(countryName: String?) -> Bool {
        if savedCountriesList.contains(where: { $0.countryName == countryName }) {
            return false
        } else {
            return true
        }
    }
    private func checkIfIsSaved(countryName: String?) -> Bool {
        if !savedCountriesList.contains(where: { $0.countryName == countryName }) {
            return false
        } else {
            return true
        }
    }
    private func findIndexOfElementInArray(countryName: String?) -> Int {
        let index = savedCountriesList.firstIndex { $0.countryName == countryName }
        return index ?? 0
    }
    
    private func retrieveSavedCountries() {
        if let data = UserDefaults.standard.value(forKey:"favouriteCountries") as? Data {
            let favouriteCountries = try? PropertyListDecoder().decode(Array<FavouriteCountriesModel>.self, from: data)
            savedCountriesList = favouriteCountries ?? []
        }
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as! CountryListTableViewCell
        cell.countryName.text = countryList?.data[indexPath.row]?.name
        cell.indexPath = indexPath.row
        self.isCountrySaved = self.checkIfIsSaved(countryName: self.countryList?.data[indexPath.row]?.name)
        if (self.isCountrySaved) {
            cell.favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        cell.buttonTapCallback = {
            self.isCountrySaved = self.checkIfCountryWillSaved(countryName: self.countryList?.data[indexPath.row]?.name)
            if (self.isCountrySaved) {
                let savedCountry = FavouriteCountriesModel(countryName: self.countryList?.data[indexPath.row]?.name ?? "", isSaved: true, countryCode: self.countryList?.data[indexPath.row]?.code ?? "")
                self.savedCountriesList.append(savedCountry)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(self.savedCountriesList), forKey:"favouriteCountries")
                cell.favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                let index = self.findIndexOfElementInArray(countryName: self.countryList?.data[indexPath.row]?.name ?? "")
                self.savedCountriesList.remove(at: index)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(self.savedCountriesList), forKey:"favouriteCountries")
                cell.favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsPageViewController") as? DetailsPageViewController {
            detailsViewController.countryCodeText = countryList?.data[indexPath.row]?.code
            detailsViewController.isCountrySaved = self.checkIfIsSaved(countryName: self.countryList?.data[indexPath.row]?.name)
            detailsViewController.indexOfCountry = self.findIndexOfElementInArray(countryName: self.countryList?.data[indexPath.row]?.name ?? "")
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
