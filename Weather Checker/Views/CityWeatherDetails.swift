//
//  CityWeatherDetails.swift
//  Weather Checker
//
//  Created by Sushant Ubale on 9/16/24.
//

import SwiftUI

struct CityWeatherDetails: View {
    let weatherData: WeatherData?
    let error: String?
    
    var body: some View {
        if error != nil {
            if let error = error {
                Text("\(error)")
                    .bold()
            }
        } else {
            VStack(alignment: .center, spacing: 20) {
                Text(weatherData?.name ?? "No city name")
                    .font(.largeTitle)
                    .bold()

                // Display weather icon based on weather condition
                if let weatherCondition = weatherData?.weather.first?.main {
                    Image(systemName: sfSymbolForWeather(condition: weatherCondition))
                        .font(.system(size: 80))
                }

                Text("\(weatherData?.main.temp ?? 0.0, specifier: "%.1f")°C")
                    .font(.title)

                HStack {
                    Text("Feels Like: \(weatherData?.main.feels_like ?? 0.0, specifier: "%.1f")°C")
                    Spacer()
                    Text("Humidity: \(weatherData?.main.humidity)%")
                }
                .font(.headline)

                HStack {
                    Text("Min: \(weatherData?.main.temp_min ?? 0.0, specifier: "%.1f")°C")
                    Spacer()
                    Text("Max: \(weatherData?.main.temp_max ?? 0.0, specifier: "%.1f")°C")
                }
                .font(.headline)
            }
            .padding()

        }
    }

    func sfSymbolForWeather(condition: String) -> String {
        switch condition.lowercased() {
        case "clear": return "sun.max.fill"
        case "clouds": return "cloud.fill"
        case "rain": return "cloud.rain.fill"
        case "snow": return "snow"
        case "thunderstorm": return "cloud.bolt.fill"
        case "drizzle": return "cloud.drizzle.fill"
        case "mist": return "cloud.fog.fill"
        default: return "questionmark.circle" // For unknown conditions
        }
    }
}

#Preview {
    CityWeatherDetails(weatherData: .init(base: "base", name: "name", cod: 1, timezone: 1, visibility: 1, dt: 1, coord: Coord.init(lon: 10, lat: 10), weather: [], main: .init(temp: 1, feels_like: 1, temp_min: 1, temp_max: 1, pressure: 1, humidity: 1, sea_level: 1, grnd_level: 1), wind: Wind.init(speed: 1, deg: 1), clouds: .init(all: 1), sys: .init(type: 1, id: 1, country: "country", sunrise: 1, sunset: 1), rain: Rain.init(oneH: 10)), error: nil)
}
