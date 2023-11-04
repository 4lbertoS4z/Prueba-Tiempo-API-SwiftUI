//
//  WeatherModelMapper.swift
//  AppTiempoMVVM
//
//  Created by alberto saz on 3/11/23.
//

import Foundation

struct WeatherModelMapper{
    func mapDataModelToModel(dataModel: WeatherResponseDataModel)-> WeatherModel{
        guard let weather = dataModel.weather.first else{
            return .empty
        }
        
        let temperature = dataModel.temperature
        
        let sunriseWithTimeZone = dataModel.sun.sunset.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        
        let sunsetWithTimeZone = dataModel.sun.sunrise.addingTimeInterval(dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        
        return WeatherModel(city: dataModel.city, weather: weather.main, description: "(\(weather.description))", iconURL: URL(string: "http://openweathermap.org/img/wn/\(weather.iconUrlString)@2x.png"), currentTemperature: "\(Int(temperature.currentTemperature))ºC",
                            minTemperature: "\(Int(temperature.minTemperature))ºC Min",
                            maxTemperature: "\(Int(temperature.maxTemperature))ºC Max",
        humidity: "\(temperature.humidity)%", sunset: sunsetWithTimeZone, sunrise: sunriseWithTimeZone)
    }
}
