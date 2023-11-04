//
//  WeatherInDaysResponseDataModel.swift
//  AppTiempoMVVM
//
//  Created by alberto saz on 3/11/23.
//


import Foundation

// MARK: - Modelos de datos correspondientes a la estructura del JSON
struct WeatherInDaysResponseDataModel: Decodable {
  
    let list: [WeatherForecast]
    let city: City
}

struct WeatherForecast: Codable, Identifiable {
    let id: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case id = "dt"
        case main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp, feelsLike = "feels_like", tempMin = "temp_min", tempMax = "temp_max"
        case pressure, seaLevel = "sea_level", grndLevel = "grnd_level", humidity
        case tempKf = "temp_kf"
    }
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
    
    var iconURL: URL? {
            URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")
        }
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Sys: Codable {
    let pod: String
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct Coord: Codable {
    let lat, lon: Double
}

