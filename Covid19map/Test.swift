//
//  Test.swift
//  Covid19map
//
//  Created by Szépfalusi István on 2020. 12. 26..
//

import Foundation
import MapKit

class Cica{
    
    func countriesNotations() -> [CountryMap] {
        struct Country: Decodable {

            let country: String?
            let alpha2: String?
            let longitude: Double?
            let latitude: Double?
        }
        
        var jsonString = ""
        if let jsonURL = Bundle.main.path(forResource: "countries", ofType: "txt"){
            do {
                jsonString = try! String(contentsOfFile: jsonURL)
            }
        } else {
            
        }
        //print(jsonString)
        
        let jsonData = jsonString.data(using: .utf8)!
        var countries: [Country] = try! JSONDecoder().decode([Country].self, from: jsonData)
        var countrycases: [CountryMap] = [CountryMap(title: countries[0].country!, alpha: countries[0].alpha2!, coordinate: CLLocationCoordinate2D(latitude: countries[0].latitude!, longitude: countries[0].longitude!))]
        countries.removeFirst()
        for i in countries {
            countrycases.append( CountryMap(title: i.country!, alpha: i.alpha2!, coordinate: CLLocationCoordinate2D(latitude: i.latitude!, longitude: i.longitude!)))
        }
        return countrycases
    }
}
