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
    
    private var countryDetails: CountryDetails?
    private var webView: WKWebView!
    private var wikiCode: String?
    
    var countryCodeText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveCountryDetails()
    }
    
    
    
    private func retrieveCountryDetails() {
        NetworkService.shared.fetchCountryDetails(countryCode: countryCodeText) { [weak self] response in
            self?.countryDetails = response.data
            DispatchQueue.main.async {
                self?.loadFlagImageFromUrl(imageURL: self?.countryDetails?.flagImageUri)
                self?.countryCodeLabel.text = self?.countryDetails?.code
                self?.wikiCode = self?.countryDetails?.wikiDataId
                
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
    
    @IBAction func navigateToWikiPage(_ sender: Any) {
        if let wikiPageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WikiPageViewController") as? WikiPageViewController {
            wikiPageViewController.wikiCode = wikiCode
            navigationController?.present(wikiPageViewController, animated: true)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
