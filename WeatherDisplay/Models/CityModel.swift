//
//  CityModel.swift
//  WeatherDisplay
//
//  Created by Isaac L. Alvarez on 4/4/26.
//
import Foundation
struct CityModel : Codable, Identifiable {
    var id: Int
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var humidity: Int
    var main: String
    var description: String
    var name: String
    var lat: Double
    var lon: Double
    var sunrise: Int
    var sunset: Int
    var timezone: Int
}
