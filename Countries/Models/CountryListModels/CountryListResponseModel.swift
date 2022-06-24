//
//  CountryListResponseModel.swift
//  Countries
//
//  Created by Enes Aydogdu on 22.06.2022.
//

import Foundation

struct CountryListResponseModel: Codable {
    
    let data: [Countries?]
    
}

struct Countries: Codable {
    
    let code: String?
    let name: String?
    let wikiDataId: String?
}
