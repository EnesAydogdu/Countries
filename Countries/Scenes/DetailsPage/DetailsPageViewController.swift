//
//  DetailsPageViewController.swift
//  Countries
//
//  Created by Enes Aydogdu on 22.06.2022.
//

import Foundation
import UIKit
import Kingfisher
import WebKit

class DetailsPageViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    private var countryDetails: CountryDetails?
    private var webView: WKWebView!
    private var wikiCode: String?
    private var countryName: String?
    
    var countryCodeText: String?
    var isCountrySaved: Bool = false
    var indexOfCountry: Int = 0
    
    var savedCountriesList: [FavouriteCountriesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveCountryDetails()
        configureFavouriteButton()
        retrieveSavedCountries()
        
    }
    
    private func retrieveCountryDetails() {
        NetworkService.shared.fetchCountryDetails(countryCode: countryCodeText) { [weak self] response,error  in
            if let response = response {
                self?.countryDetails = response.data
                DispatchQueue.main.async {
                    self?.loadFlagImageFromUrl(imageURL: self?.countryDetails?.flagImageUri)
                    self?.countryCodeLabel.text = self?.countryDetails?.code
                    self?.wikiCode = self?.countryDetails?.wikiDataId
                    self?.countryName = self?.countryDetails?.name
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Alert", message: "Too many requests. Status code: 429", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: { result in
                        self?.navigationController?.popViewController(animated: true)
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func loadFlagImageFromUrl(imageURL: String?) {
        if let url = imageURL {
            let imageUrlAsPNG = url.replacingOccurrences(of: "svg", with: "png")
            let url = URL(string: imageUrlAsPNG)
            flagImageView.kf.setImage(with: url)
        }
        
    }
    
    private func configureFavouriteButton() {
        if (isCountrySaved) {
            favouriteButton.image = UIImage(systemName: "star.fill")
        } else {
            favouriteButton.image = UIImage(systemName: "star")
        }
    }
    
    private func checkIfCountryWillSaved(countryName: String?) -> Bool {
        if savedCountriesList.contains(where: { $0.countryName == countryName }) {
            return false
        } else {
            return true
        }
    }
    
    private func retrieveSavedCountries() {
        if let data = UserDefaults.standard.value(forKey:"favouriteCountries") as? Data {
            let favouriteCountries = try? PropertyListDecoder().decode(Array<FavouriteCountriesModel>.self, from: data)
            savedCountriesList = favouriteCountries ?? []
        }
    }
    
    
    @IBAction func navigateToWikiPage(_ sender: Any) {
        if let wikiPageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WikiPageViewController") as? WikiPageViewController {
            wikiPageViewController.wikiCode = wikiCode
            navigationController?.present(wikiPageViewController, animated: true)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTappedFavouriteButton(_ sender: Any) {
        if (!isCountrySaved) {
            let savedCountry = FavouriteCountriesModel(countryName: countryDetails?.name ?? "", isSaved: true, countryCode: countryCodeText ?? "")
            self.savedCountriesList.append(savedCountry)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.savedCountriesList), forKey:"favouriteCountries")
            favouriteButton.image = UIImage(systemName: "star.fill")
        } else {
            self.savedCountriesList.remove(at: indexOfCountry)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.savedCountriesList), forKey:"favouriteCountries")
            favouriteButton.image = UIImage(systemName: "star")
        }
    }
    
}
