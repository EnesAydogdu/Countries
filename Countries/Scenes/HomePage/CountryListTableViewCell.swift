//
//  CountryListTableViewCell.swift
//  Countries
//
//  Created by Enes Aydogdu on 22.06.2022.
//

import Foundation
import UIKit

class CountryListTableViewCell: UITableViewCell {
    
    private var isCountrySaved: Bool = false
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.layer.borderColor = UIColor.lightGray.cgColor
            borderView.layer.borderWidth = 2
            borderView.layer.cornerRadius = CGFloat(5)
            borderView.layer.shadowOffset = CGSize(width: -10, height: -10)
            borderView.layer.shadowRadius = -5.0
            borderView.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBAction func dipTappedFavouriteButton(_ sender: Any) {
        if !isCountrySaved {
            isCountrySaved = true
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            isCountrySaved = false
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
