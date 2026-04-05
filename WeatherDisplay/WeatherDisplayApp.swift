//
//  WeatherDisplayApp.swift
//  WeatherDisplay
//
//  Created by Isaac L. Alvarez on 4/3/26.
//
import SwiftUI
@main
struct WeatherDisplayApp: App {
    @StateObject var locations = WeatherDisplayViewModel()
    @State private var hasSeenIntro = false
    var body: some Scene {
        WindowGroup {
            if hasSeenIntro {
                ContentView()
                    .environmentObject(locations)
            } else {
                IntroView() {
                    hasSeenIntro = true
                }
                    .environmentObject(locations)
            }
        }
    }
}
