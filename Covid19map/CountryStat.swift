//
//  CountryStat.swift
//  Covid19map
//
//  Created by Szépfalusi István on 2020. 12. 25..
//

import Foundation


class CountryStat: Codable {
    let name: String?
    let slug: String?
    let totalconfirmed: Int?
    let totalrecovered: Int?
    let totaldeaths: Int?
    let newconfirmed: Int?
    let newrecovered: Int?
    let newdeaths: Int?
    let active: Int?
    let date: Date?

    
    
    init(name: String?,slug: String?, totalconfirmed: Int?, totalrecovered: Int?, totaldeaths: Int?,newconfirmed: Int?, newrecovered: Int?, newdeaths: Int?,active: Int?, date: Date?) {
        self.name = name
        self.slug = slug
        self.totalconfirmed = totalconfirmed
        self.totalrecovered = totalrecovered
        self.totaldeaths = totaldeaths
        self.newconfirmed = newconfirmed
        self.newrecovered = newrecovered
        self.newdeaths = newdeaths
        self.active = active
        self.date = date
    }
    
    
    init?(json: [String: Any]){
        let name = json["Country"] as? String
        let slug = json["Slug"] as? String
        let totalconfirmed = json["TotalConfirmed"] as? Int
        let totalrecovered = json["TotalRecovered"] as? Int
        let totaldeaths = json["TotalDeaths"] as? Int
        let newconfirmed = json["NewConfirmed"] as? Int
        let newrecovered = json["NewRecovered"] as? Int
        let newdeaths = json["NewDeaths"] as? Int
          

        let active = totalconfirmed!-totalrecovered!-totaldeaths!
        
        
        self.name = name
        self.slug = slug
        self.totalconfirmed = totalconfirmed
        self.totalrecovered = totalrecovered
        self.totaldeaths = totaldeaths
        self.newconfirmed = newconfirmed
        self.newrecovered = newrecovered
        self.newdeaths = newdeaths
        self.active = active
        self.date = nil
    }
    init?(jsonwithDate: [String: Any]){
        let name = jsonwithDate["Country"] as? String
        let totalconfirmed = jsonwithDate["Confirmed"] as? Int
        let totalrecovered = jsonwithDate["Recovered"] as? Int
        let totaldeaths = jsonwithDate["Deaths"] as? Int
        let active = jsonwithDate["Active"] as? Int
        let datestring = jsonwithDate["Date"] as? String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date: Date = formatter.date(from: datestring!)!
        
        self.name = name
        self.totalconfirmed = totalconfirmed
        self.totalrecovered = totalrecovered
        self.totaldeaths = totaldeaths
        self.newconfirmed = nil
        self.newrecovered = nil
        self.newdeaths = nil
        self.slug = nil
        self.active = active
        self.date = date
    }
    
    
    
}
