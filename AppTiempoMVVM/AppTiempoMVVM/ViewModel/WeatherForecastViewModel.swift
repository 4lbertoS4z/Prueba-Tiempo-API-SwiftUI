import Foundation

final class WeatherForecastViewModel: ObservableObject {
    @Published var forecasts: [WeatherDaysModel] = []
    private let weatherDaysModelMapper: WeatherDaysModelMapper = WeatherDaysModelMapper()

    func getWeatherForecast(city: String) async {
        let apiKey = "b62d74a05541d78c1dd106c45f18a4db"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric&lang=es"

        guard let url = URL(string: urlString) else {
            print("URL no válida")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Respuesta no válida de la API")
                return
            }

            let decodedResponse = try JSONDecoder().decode(WeatherInDaysResponseDataModel.self, from: data)
            DispatchQueue.main.async {
                // Aquí se usa el mapper para convertir los datos del modelo de respuesta al modelo de vista.
                self.forecasts = self.weatherDaysModelMapper.daysMapDataModelToModel(dataModel: decodedResponse)
            }
        } catch {
            DispatchQueue.main.async {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
