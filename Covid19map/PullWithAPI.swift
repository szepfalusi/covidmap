//
//  PullWithAPI.swift
//  Covid19map
//
//  Created by István Szépfalusi on 2021. 01. 14..
//

import Foundation

class PullWithAPI {
    
    func pullwithAPIandAdd() -> [CountryStat]{
        
        var countryarray: [CountryStat] = []
    
        if let url = URL(string: "https://api.covid19api.com/summary") {
            let semaphore = DispatchSemaphore(value: 0)
           URLSession.shared.dataTask(with: url,completionHandler: { data, response, error in
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let array = json as? [String: Any]{
                if let global = array["Global"] as? [String: Any]{
                        let x = CountryStat(json: global)
                        countryarray.append(x!)
                    
                }
                if let nestarr = array["Countries"] as? [[String: Any]]{
                    for i in nestarr {
                        let x = CountryStat(json: i)
                        //print(x!.name as Any)
                        countryarray.append(x!)
                    }
                }

            }
            semaphore.signal()
           }).resume()
            semaphore.wait()
            return countryarray
        }
        return countryarray
    }
    
    func pullDailyCases(name: String, coarr: [CountryStat]) -> [CountryStat] {
        var dailyarray: [CountryStat] = []
        if coarr.first(where: {$0.name==name}) != nil {

                let semaphore = DispatchSemaphore(value: 0)
                var slug: String = ""
                for i in coarr {
                    if i.name == name {
                        slug = i.slug!
                    }
                }
                let stringurl = "https://api.covid19api.com/total/dayone/country/"+slug
                
                if let url = URL(string: stringurl) {
                   URLSession.shared.dataTask(with: url,completionHandler: { data, response, error in
                    
                    dailyarray = try! JSONDecoder().decode([CountryStat].self, from: data!)
                    
                    let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                    if let array = json as? [[String: Any]]{
                        for i in array {
                            let x = CountryStat(jsonwithDate: i)
                            dailyarray.append(x!)
                           // print(x?.name)
                        }
                        
                    }
                    semaphore.signal()
                   }).resume()
                    semaphore.wait()
                    //print("Visszaadtam a tömböt")
                    return dailyarray
                    
                }
                return dailyarray
            } else {
                return dailyarray
            }

    }
    
    

}
