//
//  CityDetailView.swift
//  WeatherDisplay
//
//  Created by Isaac L. Alvarez on 4/4/26.
//
import SwiftUI
import MapKit
struct CityDetailView: View {
    var city: CityModel
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: city.lat, longitude: city.lon)
    }
    private func formattedTime(from timestamp: Int) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.timeZone = TimeZone(secondsFromGMT: city.timezone)
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(city.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                Map {
                    Marker(city.name, coordinate: coordinate)
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("Temperature")
                    .font(.headline)
                Text("\(Int(city.temp.rounded()))°F")
                    .font(.subheadline)
                Text("Feels Like")
                    .font(.headline)
                Text("\(Int(city.feels_like.rounded()))°F")
                    .font(.subheadline)
                Text("Low")
                    .font(.headline)
                Text("\(Int(city.temp_min.rounded()))°F")
                    .font(.subheadline)
                Text("High")
                    .font(.headline)
                Text("\(Int(city.temp_max.rounded()))°F")
                    .font(.subheadline)
                Text("Conditions")
                    .font(.headline)
                Text(city.main)
                    .font(.subheadline)
                Text("Description")
                    .font(.headline)
                Text(city.description.capitalized)
                    .font(.subheadline)
                Text("Humidity")
                    .font(.headline)
                Text("\(city.humidity)%")
                    .font(.subheadline)
                Text("Sunrise")
                    .font(.headline)
                Text(formattedTime(from: city.sunrise))
                    .font(.subheadline)
                Text("Sunset")
                    .font(.headline)
                Text(formattedTime(from: city.sunset))
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}
#Preview {
    NavigationStack {
        CityDetailView(
            city: CityModel(
                id: 4684888,
                temp: 75,
                feels_like: 77,
                temp_min: 72,
                temp_max: 80,
                humidity: 48,
                main: "Clouds",
                description: "Scattered Clouds",
                name: "Dallas",
                lat: 32.7767,
                lon: -96.7970,
                sunrise: 1_743_855_480,
                sunset: 1_743_902_520,
                timezone: -18_000
            )
        )
    }
}
