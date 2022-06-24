//
//  FavouriteListTableViewCell.swift
//  Countries
//
//  Created by Enes Aydogdu on 22.06.2022.
//

import Foundation
import UIKit
import CoreData

class FavouriteListTableViewCell: UITableViewCell {
    
    var completion: (() -> ())?
    
    @IBOutlet weak var savedCountryName: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
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
    var indexPath: Int?

    @IBAction func didTappedSaveButton(_ sender: Any) {
        completion
    }
}
