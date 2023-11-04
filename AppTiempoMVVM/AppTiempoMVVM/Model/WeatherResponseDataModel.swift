//
//  WeatherResponseDataModel.swift
//  AppTiempoMVVM
//
//  Created by alberto saz on 3/11/23.
//

import Foundation

struct WeatherResponseDataModel: Decodable {
    let city: String
    let weather: [WeatherDataModel]
    let temperature: TemperatureDataModel
    let sun: SunModel
    let timezone: Double
    
    enum CodingKeys: String, CodingKey{
        case city = "name"
        case weather
        case temperature = "main"
        case sun = "sys"
        case timezone
    }
}

struct SunModel: Decodable{
    let sunrise: Date
    let sunset: Date
}

struct WeatherDataModel:Decodable{
    let main: String
    let description: String
    let iconUrlString: String
    
    enum CodingKeys: String, CodingKey{
        case main
        case description
        case iconUrlString = "icon"
    }
}

struct TemperatureDataModel: Decodable{
    let currentTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    
    enum CodingKeys: String,CodingKey{
        case currentTemperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
}
