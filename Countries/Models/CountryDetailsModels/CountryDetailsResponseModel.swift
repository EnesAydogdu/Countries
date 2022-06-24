//
//  CountryDetailsResponseModel.swift
//  Countries
//
//  Created by Enes Aydogdu on 23.06.2022.
//

import Foundation

struct CountryDetailsResponseModel: Codable {
    var data: CountryDetails?
}

struct CountryDetails: Codable {
    var code: String?
    var flagImageUri: String?
    var wikiDataId: String?
    var name: String?
}
