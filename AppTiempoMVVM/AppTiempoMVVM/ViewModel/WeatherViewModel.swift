import Foundation
final class WeatherViewModel: ObservableObject {
    
    @Published var weatherModel: WeatherModel = .empty
    private let weatherModelMapper: WeatherModelMapper = WeatherModelMapper()
    @Published var weatherFetchError: Bool = false
    
    func getWeather(city: String) async {
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=71c3e78149e90edcb26b5c8bf57708fa&units=metric&lang=es"
            guard let url = URL(string: urlString) else { return }

            do {
                async let (data, _) = try await URLSession.shared.data(from: url)
                let dataModel = try await JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.weatherModel = self.weatherModelMapper.mapDataModelToModel(dataModel: dataModel)
                    self.weatherFetchError = false
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.weatherFetchError = true
                }
                print(error.localizedDescription)
            }
        }
    }
