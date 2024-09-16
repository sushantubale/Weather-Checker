//
//  WeatherLatLonViewModel.swift
//  Weather Checker
//
//  Created by Sushant Ubale on 9/3/24.
//

import Foundation
import SwiftUI
import Combine

class WeatherLatLonViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    @Published var weatherData: WeatherData?
    @Published var gotDetails = false

    func getCityClimate(cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=a659418643400606c265514c8c4ba943") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                }
            } receiveValue: { [weak self] jsonData in
                guard let strongSelf = self else {return}
                strongSelf.weatherData = jsonData
                strongSelf.gotDetails = true
            }
            .store(in: &cancellable)
    }
}

