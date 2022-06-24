//
//  NetworkService.swift
//  Countries
//
//  Created by Enes Aydogdu on 22.06.2022.
//

import Foundation

struct NetworkService {
    
    private let baseURL = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries"
    
    static let shared = NetworkService()
    
    func fetchCountryList(completion: @escaping (CountryListResponseModel) -> ()) {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "10")
        ]
        let url = urlComponents?.url?.absoluteURL
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setValue("e3a55d6dcfmsh1dcb4f3754bf963p1c2b6djsn3df51243dee5", forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("wft-geo-db.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("Limit", forHTTPHeaderField: "10")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let countries = try decoder.decode(CountryListResponseModel.self, from: data)
                    completion(countries)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

