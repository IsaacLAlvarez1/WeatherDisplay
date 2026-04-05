//
//  WeatherDisplayViewModel.swift
//  WeatherDisplay
//
//  Created by Isaac L. Alvarez on 4/3/26.
//
import Combine
import Foundation
private struct WeatherResponse: Decodable {
    struct Forecast: Decodable {
        struct Main: Decodable {
            let temp, feels_like, temp_min, temp_max: Double
            let humidity: Int
        }
        struct Condition: Decodable {
            let main, description: String
        }
        let main: Main
        let weather: [Condition]
    }
    struct City: Decodable {
        struct Coordinate: Decodable { let lat, lon: Double }
        let id: Int
        let name: String
        let coord: Coordinate
        let timezone: Int
        let sunrise, sunset: Int
    }
    let list: [Forecast]
    let city: City
    var cityModel: CityModel? {
        guard let f = list.first, let condition = f.weather.first else { return nil }
        return CityModel(
            id:          city.id,
            temp:        f.main.temp,
            feels_like:  f.main.feels_like,
            temp_min:    f.main.temp_min,
            temp_max:    f.main.temp_max,
            humidity:    f.main.humidity,
            main:        condition.main,
            description: condition.description,
            name:        city.name,
            lat:         city.coord.lat,
            lon:         city.coord.lon,
            sunrise:     city.sunrise,
            sunset:      city.sunset,
            timezone:    city.timezone
        )
    }
}
final class WeatherDisplayViewModel: ObservableObject {
    @Published var introPages: [IntroPage] = []
    @Published var weatherData: [CityModel] = []
    @Published var selectedPage: Int = 0
    func loadIntroPages() {
        guard introPages.isEmpty else { return }
        let images = (1...3).map(String.init)
        let captions = [
            "Fun in the sun",
            "A rainy day",
            "Snow on the way"
        ]
        introPages = zip(images, captions).map {
            IntroPage(imageName: $0, caption: $1)
        }
    }
    func fetchWeather(id: Int) {
        guard let url = weatherURL(for: id) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let data else {
                print("No data returned")
                return
            }
            Task { @MainActor in
                do {
                    let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    self.weatherData = response.cityModel.map { [$0] } ?? []
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
    private func weatherURL(for id: Int) -> URL? {
        guard var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast") else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: "id", value: String(id)),
            URLQueryItem(name: "appid", value: "f380570ebccbc2baa111c87c93d2cacc"),
            URLQueryItem(name: "cnt", value: "1"),
            URLQueryItem(name: "units", value: "imperial")
        ]
        return components.url
    }
}
