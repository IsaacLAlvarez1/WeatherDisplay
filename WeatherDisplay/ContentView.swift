//
//  ContentView.swift
//  WeatherDisplay
//
//  Created by Isaac L. Alvarez on 4/3/26.
//
import SwiftUI
struct City: Identifiable, Hashable {
    let id: Int
    let name: String
    static let topTenUS: [City] = [
        City(id: 5128638, name: "New York"),
        City(id: 5368361, name: "Los Angeles"),
        City(id: 4887398, name: "Chicago"),
        City(id: 4699066, name: "Houston"),
        City(id: 4905873, name: "Phoenix"),
        City(id: 4560349, name: "Philadelphia"),
        City(id: 4726206, name: "San Antonio"),
        City(id: 4726311, name: "San Diego"),
        City(id: 4684888, name: "Dallas"),
        City(id: 5392171, name: "San Jose"),
    ]
}
struct ContentView: View {
    @EnvironmentObject var locations: WeatherDisplayViewModel
    @State private var city: City = City.topTenUS[8]
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Picker("Select a City", selection: $city) {
                    ForEach(City.topTenUS) { selectedCity in
                        Text(selectedCity.name).tag(selectedCity)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 300, height: 150)
                NavigationLink {
                    if let weather = locations.weatherData.first {
                        CityDetailView(city: weather)
                    } else {
                        ProgressView("Loading weather for \(city.name)...")
                    }
                } label: {
                    Text("Find the weather for \(city.name)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Find the Local Weather")
            .onAppear {
                locations.fetchWeather(id: city.id)
            }
            .onChange(of: city) { _, newCity in
                locations.fetchWeather(id: newCity.id)
            }
        }
    }
}
#Preview {
    ContentView()
}
