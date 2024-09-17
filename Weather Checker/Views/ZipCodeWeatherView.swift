//
//  ZipCodeWeatherView.swift
//  Weather Checker
//
//  Created by Sushant Ubale on 9/16/24.
//

import SwiftUI

struct ZipCodeWeatherView: View {
    @State private var zipCode: String = ""
    @State private var countryCode: String = "US"

    @ObservedObject private var weatherViewModel = WeatherLatLonViewModel()

    var body: some View {
        VStack(spacing: 24) {
            TextField("Enter ZipCode", text: $zipCode)
                .padding()
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 2.0))
                        .foregroundColor(.blue)
                }
                .font(.title)
                .shadow(color: .blue.opacity(0.2), radius: 5, x: 0, y: 5)
            
            TextField("Select Country Code", text: $countryCode)
                .padding()
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 2.0))
                        .foregroundColor(.blue)
                }
                .font(.title)
                .shadow(color: .blue.opacity(0.2), radius: 5, x: 0, y: 5)
            
            Button {
                weatherViewModel.getZipWeather(zipCode: zipCode, countryCode: countryCode)
            } label: {
                Text("Submit")
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .foregroundColor(.white)
                    .bold()
            }
            .sheet(isPresented: $weatherViewModel.gotZipCodeData, content: {
                if let weatherData = weatherViewModel.weatherData {
                    CityWeatherDetails(weatherData: weatherData, error: nil)
                } else if let errorFetchingData = weatherViewModel.errorFetchingData {
                    CityWeatherDetails(weatherData: nil, error: errorFetchingData)
                }
            })
        }
        .padding()
    }
}

#Preview {
    ZipCodeWeatherView()
}
