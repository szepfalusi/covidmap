//
//  CountryMap.swift
//  Covid19map
//
//  Created by Szépfalusi István on 2020. 12. 23..
//

import Foundation
import MapKit

class CountryMap: NSObject, MKAnnotation{
    let title: String?
    let alpha: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?,alpha: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.alpha = alpha
        self.coordinate = coordinate
        
    }
    
    init?(json: [String: Any]) {
        guard let title = json["country"] as? String,
            let latitude = json["latitude"] as? Double,
            let longitude = json["longitude"] as? Double,
            let alpha = json["alpha2"] as? String
        else {
            return nil
        }
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.title = title
        self.alpha = alpha
        self.coordinate = coordinates
        
    }
    
}
