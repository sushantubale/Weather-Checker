//
//  ContentView.swift
//  Weather Checker
//
//  Created by Sushant Ubale on 9/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var firstCity: String = ""
    @ObservedObject private var weatherViewModel = WeatherLatLonViewModel()
    @State private var selection = 0
    
    var handler: Binding<Int> { 
        Binding(
        get: { self.selection },
        set: {
            if $0 == self.selection {
                print("Reset here!!")
            }
            self.selection = $0
        }
    )}

    var body: some View {
        TabView(selection: handler,
                content:  {
            VStack(spacing: 36) {
                TextField("Enter city", text: $firstCity)
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
                    weatherViewModel.getCityClimate(cityName: firstCity)
                } label: {
                    Text("Submit")
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .foregroundColor(.white)
                        .bold()
                }
                .sheet(isPresented: $weatherViewModel.gotDetails, content: {
                    if let weatherData = weatherViewModel.weatherData {
                        CityWeatherDetails(weatherData: weatherData, error: nil)
                    } else if let error =  weatherViewModel.errorFetchingData {
                        CityWeatherDetails(weatherData: nil, error: error)
                    }
                })
            }
            .tabItem { Text("City") }
            .tag(1)
            .padding()
            ZipCodeWeatherView()
                .tabItem { Text("Zip Code") }
                .tag(2)
        })
    }
}

#Preview {
    ContentView()
}
