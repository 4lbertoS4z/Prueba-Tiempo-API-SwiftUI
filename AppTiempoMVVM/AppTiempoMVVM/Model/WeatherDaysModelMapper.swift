//
//  WeatherDaysModelMapper.swift
//  AppTiempoMVVM
//
//  Created by alberto saz on 4/11/23.
//

import Foundation

struct WeatherDaysModelMapper {
    func daysMapDataModelToModel(dataModel: WeatherInDaysResponseDataModel) -> [WeatherDaysModel] {
        return dataModel.list.map { item in
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            let date = Date(timeIntervalSince1970: TimeInterval(item.id))
            _ = dateFormatter.string(from: date)
            let weatherCondition = item.weather.first?.description ?? ""
            let iconCode = item.weather.first?.icon ?? ""
            let iconURL = URL(string: "http://openweathermap.org/img/wn/\(iconCode)@2x.png")
            let temp = "\(item.main.temp)ºC"  // Asumiendo que main.temp es un Double
            let humidity = "\(item.main.humidity)%"
            let main = item.weather.first?.main ?? ""

            return WeatherDaysModel(dtTxt: date,
                                    weather: weatherCondition,
                                    icon: iconURL,
                                    temp: temp,
                                    humidity: humidity,
                                    main: main)
        }
    }
}
