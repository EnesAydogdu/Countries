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
    @IBOutlet weak var countryListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveCountryList()
        configureTableView()
        
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
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as! CountryListTableViewCell
        cell.countryName.text = countryList?.data[indexPath.row]?.name
        cell.indexPath = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsPageViewController") as? DetailsPageViewController {
            detailsViewController.countryCodeText = countryList?.data[indexPath.row]?.code
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
