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
    @Published var gotZipCodeData = false
    @Published var errorFetchingData: String?
    
    func getCityClimate(cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=a659418643400606c265514c8c4ba943") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                    self?.gotDetails = true
                    self?.errorFetchingData = error.localizedDescription
                }
            } receiveValue: { [weak self] jsonData in
                guard let strongSelf = self else {return}
                strongSelf.weatherData = jsonData
                strongSelf.gotDetails = true
            }
            .store(in: &cancellable)
    }
    
    func getZipWeather(zipCode: String, countryCode: String = "us") {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?zip=\(zipCode),\(countryCode)&appid=a659418643400606c265514c8c4ba943") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                    self?.gotZipCodeData = true
                    self?.errorFetchingData = error.localizedDescription
                }
            } receiveValue: { [weak self] jsonData in
                guard let strongSelf = self else {return}
                strongSelf.weatherData = jsonData
                strongSelf.gotZipCodeData = true
            }
            .store(in: &cancellable)
    }
}

