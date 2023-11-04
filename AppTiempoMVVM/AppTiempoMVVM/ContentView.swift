//
//  ContentView.swift
//  AppTiempoMVVM
//
//  Created by alberto saz on 3/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    @StateObject var viewModel = WeatherForecastViewModel()
    
    @State private var cityName: String = UserDefaults.standard.string(forKey: "cityName") ?? ""
    @State private var showingAlert = false
    @State private var showingForecast = false
    
    var body: some View {
        VStack{
            VStack{
                HStack {
                    TextField("Introduce la ciudad", text: $cityName)
                        .textFieldStyle(.roundedBorder)
                        .padding()

                    Button(action: {
                        let trimmedCityName = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
                        UserDefaults.standard.set(trimmedCityName, forKey: "cityName")
                        UserDefaults.standard.synchronize()
                        Task {
                            await weatherViewModel.getWeather(city: trimmedCityName)
                            await viewModel.getWeatherForecast(city: trimmedCityName)
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .font(.title)
                            .padding(4)
                            .background(.cyan)
                            
                    }
                }
                .padding(.horizontal)
                Text(weatherViewModel.weatherModel.city)
                    .foregroundStyle(.white)
                    .font(.system(size: 70))
                Text(weatherViewModel.weatherModel.weather.description)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.bottom, 8)
                HStack{
                    if let url = weatherViewModel.weatherModel.iconURL{
                        AsyncImage(url: url){
                            image in image
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text(weatherViewModel.weatherModel.currentTemperature)
                        .font(.system(size: 70))
                        .foregroundStyle(.white)
                }
                .padding(.top, -20)
                HStack(spacing: 14){
                    Label(weatherViewModel.weatherModel.maxTemperature, systemImage: "thermometer.sun.fill")
                    Label(weatherViewModel.weatherModel.minTemperature, systemImage: "thermometer.snowflake")
                }
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(.white)
                Divider()
                    .foregroundStyle(.white)
                    .padding()
                HStack(spacing: 32){
                    VStack {
                        Image(systemName: "sunrise.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(weatherViewModel.weatherModel.sunset, style: .time)
                    }
                    VStack {
                        Image(systemName: "sunset.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(weatherViewModel.weatherModel.sunrise, style: .time)
                    }
                    
                    
                }
                .foregroundStyle(.white)
                Divider()
                    .foregroundStyle(.white)
                    .padding()
                Label(weatherViewModel.weatherModel.humidity, systemImage: "humidity.fill")
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.white)
                Spacer()
            }
          
            .padding(.top, 32)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    if viewModel.forecasts.isEmpty {
                        Text("Cargando datos del tiempo...")
                    } else {
                        ForEach(viewModel.forecasts) { day in
                            VStack {
                                Text(day.dtTxt)
                                    .font(.headline)
                                    .lineLimit(2)
                                VStack(alignment: .leading) {
                                    Text("Temp: \(day.main.temp, specifier: "%.1f")°C")
                                    HStack{
                                        if let url = day.weather.first?.iconURL {
                                            AsyncImage(url: url) { image in
                                                image.resizable()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 50, height: 50) // Ajusta el tamaño según sea necesario
                                        }
                                        Text(day.weather.first?.main ?? "")
                                    }
                                  
                                    Text("Humedad: \(day.main.humidity)%")
                                }
                            }
                            .frame(width: 204) // Puedes ajustar la anchura como prefieras
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.3)))
                            
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 200) // Ajusta la altura como prefieras
            
            Spacer()
        }
        .background(LinearGradient(colors:[.blue, .cyan, .yellow],startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .onAppear {
            if let savedCityName = UserDefaults.standard.string(forKey: "cityName"), !savedCityName.isEmpty {
                cityName = savedCityName
                Task {
                    await weatherViewModel.getWeather(city: savedCityName)
                    await viewModel.getWeatherForecast(city: savedCityName)
                }
            }
        }
        .alert("Ciudad no encontrada", isPresented: $weatherViewModel.weatherFetchError) {
            Button("OK", role: .cancel) {
                // Limpia el nombre de la ciudad y el modelo si la búsqueda falló.
                cityName = ""
                UserDefaults.standard.removeObject(forKey: "cityName")
                weatherViewModel.weatherModel = WeatherModel.empty
            }
        }
    }
}


#Preview {
    ContentView()
}
