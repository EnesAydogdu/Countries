//
//  FavouritePageViewController.swift
//  Countries
//
//  Created by Enes Aydogdu on 22.06.2022.
//

import Foundation
import UIKit

class FavouritePageViewController: UIViewController {
    
        
    @IBOutlet weak var savedCountriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
}

//extension FavouritePageViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return countryList.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteListTableViewCell", for: indexPath) as! FavouriteListTableViewCell
//        print(countryList[indexPath.row].countryName)
//        cell.savedCountryName?.text = countryList[indexPath.row].countryName
//        cell.indexPath = indexPath.row
//        cell.selectionStyle = .none
//        return cell
//    }
//    
//}
//
