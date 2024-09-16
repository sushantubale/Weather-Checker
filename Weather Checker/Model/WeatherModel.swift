import Foundation

struct WeatherData: Codable {
    let base: String?
    let name: String
    let cod: Int
    let timezone: Int
    let visibility: Int
    let dt: Int
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let rain: Rain? // Optional since it might not always be present
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let
 feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int

}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct
 Rain: Codable {
    let oneH: Double? // Optional since it's nested within a dictionary

    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}
