//
//  DetailView.swift
//  Forecast
//
//  Created by Amit Swiift on 03/01/24.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Property
    @StateObject var weatherVM: WeatherViewModel
    // MARK: - Body
    var body: some View {
        if let current = weatherVM.current {
            Divider()
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        DetailCell(title: "Sunrise", detail: "\(current.sunrise.hourMinuteAmPm(weatherVM.timeZoneOffset))")
                        DetailCell(title: "Pressure", detail: "\(current.pressure) hPa")
                        DetailCell(title: "Visibility", detail: "\(current.visibility/1000) Km")
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        DetailCell(title: "Sunset", detail: "\(current.sunset.hourMinuteAmPm(weatherVM.timeZoneOffset))")
                        DetailCell(title: "Wind", detail: "\(current.windSpeedWithDirection)")
                        DetailCell(title: "UV Index", detail: current.uvi.roundedString(to: 0))
                    }
                }
            }.padding(.horizontal)
        }
    }
}
