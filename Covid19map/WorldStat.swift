//
//  WorldStat.swift
//  Covid19map
//
//  Created by István Szépfalusi on 2021. 01. 16..
//

import Foundation


class WorldStat: Codable{
    let totalconfirmed: Int?
    let totalrecovered: Int?
    let totaldeaths: Int?
    let newconfirmed: Int?
    let newrecovered: Int?
    let newdeaths: Int?
    let active: Int?

    
    
    init(totalconfirmed: Int?, totalrecovered: Int?, totaldeaths: Int?,newconfirmed: Int?, newrecovered: Int?, newdeaths: Int?,active: Int?) {
        self.totalconfirmed = totalconfirmed
        self.totalrecovered = totalrecovered
        self.totaldeaths = totaldeaths
        self.newconfirmed = newconfirmed
        self.newrecovered = newrecovered
        self.newdeaths = newdeaths
        self.active = active
    }
    
    
    init?(json: [String: Any]){
        let totalconfirmed = json["TotalConfirmed"] as? Int
        let totalrecovered = json["TotalRecovered"] as? Int
        let totaldeaths = json["TotalDeaths"] as? Int
        let newconfirmed = json["NewConfirmed"] as? Int
        let newrecovered = json["NewRecovered"] as? Int
        let newdeaths = json["NewDeaths"] as? Int

        let active = totalconfirmed!-totalrecovered!-totaldeaths!
        
        self.totalconfirmed = totalconfirmed
        self.totalrecovered = totalrecovered
        self.totaldeaths = totaldeaths
        self.newconfirmed = newconfirmed
        self.newrecovered = newrecovered
        self.newdeaths = newdeaths
        self.active = active

    }
}
