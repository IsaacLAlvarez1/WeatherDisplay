//
//  IntroView.swift
//  WeatherDisplay
//
//  Created by Isaac L. Alvarez on 4/3/26.
//
import SwiftUI
struct IntroView: View {
    @EnvironmentObject var locations : WeatherDisplayViewModel
    var onFinish: () -> Void = {}
    var body: some View {
        VStack {
            TabView {
                ForEach(locations.introPages) { page in
                    VStack(spacing: 10) {
                        Spacer()
                        Image(page.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 400, height: 500)
                            .clipped()
                        Text(page.caption)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .padding()
            Button(action: {
                onFinish()
            }) {
                Text("Search for My Location")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .onAppear{
            locations.loadIntroPages()
        }
    }
}
#Preview {
    IntroView()
        .environmentObject(WeatherDisplayViewModel())
}
