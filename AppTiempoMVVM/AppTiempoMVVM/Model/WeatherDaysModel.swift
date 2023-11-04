//
//  WeatherDaysModel.swift
//  AppTiempoMVVM
//
//  Created by alberto saz on 4/11/23.
//

import Foundation

struct WeatherDaysModel: Identifiable {
    var id: Date { dtTxt }
    let dtTxt: Date
    let weather: String
    let icon: URL?
    let temp: String
    let humidity: String
    let main: String
    
    static let emptyDays: WeatherDaysModel = .init(dtTxt: .now, weather: "", icon: nil, temp: "", humidity: "", main: "")
    
}
