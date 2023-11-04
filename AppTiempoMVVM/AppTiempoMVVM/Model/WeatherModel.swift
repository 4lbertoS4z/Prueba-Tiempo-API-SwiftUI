//
//  WeatherModel.swift
//  AppTiempoMVVM
//
//  Created by alberto saz on 3/11/23.
//

import Foundation

struct WeatherModel{
    let city: String
    let weather: String
    let description: String
    let iconURL: URL?
    let currentTemperature: String
    let minTemperature: String
    let maxTemperature: String
    let humidity: String
    let sunset: Date
    let sunrise: Date
    
    
    static let empty: WeatherModel = .init(city: "No city", weather: "NO Weather", description: "String", iconURL: nil, currentTemperature: "0ºC", minTemperature: "0ºC Min", maxTemperature: "0ºC Max", humidity: "0%", sunset: .now, sunrise: .now)
}
