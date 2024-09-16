//
//  Constants.swift
//  Weather Checker
//
//  Created by Sushant Ubale on 9/3/24.
//

import Foundation

struct APIData {
    
    var apiKey = "a7178f0db3a784754c962bf77a8c4db6"
    var lat: String?
    var lon: String?
    
    init(lat: String? = nil, lon: String? = nil) {
        self.lat = lat
        self.lon = lon
    }
    
    func setupLatLonURL(lat: String, lon: String) -> String {
        return "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude={part}&appid=\(apiKey)"
    }
}
