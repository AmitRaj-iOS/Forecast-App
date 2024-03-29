//
//  CurrentView.swift
//  Forecast
//
//  Created by Amit Swiift on 03/01/24.
//

import SwiftUI

struct CurrentView: View {
    // MARK: - Property
    @StateObject var weatherVM: WeatherViewModel
    // MARK: - Body
    var body: some View {
        // MARK: - Current View 
            if let current = weatherVM.current {
                VStack(spacing: 2) {
                    Text(weatherVM.currentCityName)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text(current.weather[0].description.capitalized)
                        Divider()
                        Divider()
                        Text("Feels Like: \(current.feels_like.roundedString(to: 0))°")
                    }.fixedSize()
                    HStack {
                        Text("\(current.temp.roundedString(to: 0))°")
                        Divider()
                        Divider()
                        Image(systemName: current.weather[0].iconImage).renderingMode(.original)
                    }.fixedSize().font(.system(size: 75)).padding()
                    HStack {
                        Text("Cloud: \((current.clouds))%")
                        Divider()
                        Text("Humidity: \(current.humidity)%")
                    }.fixedSize()
            }
        }
    }
}
