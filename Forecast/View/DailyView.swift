//
//  DailyView.swift
//  Forecast
//
//  Created by Amit Swiift on 03/01/24.
//

import SwiftUI

struct DailyView: View {
    @StateObject var weatherVM: WeatherViewModel
    
    var body: some View {
        if let daily = weatherVM.daily {
            VStack(alignment: .leading) {
                
       
                Text("5 - Day Forecast").bold()
                    .padding(.horizontal)
              //  ScrollView(.horizontal, showsIndicators: false) {
                    VStack {
                        ForEach(daily.prefix(5) , id: \.dt) { day in
                            ZStack {
                                
                                HStack{
                                    Text(daily[0].dt == day.dt ? "Today": day.dt.dayDateMonth)
                                        .fontWeight(.bold)
                                        .fixedSize()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    Spacer()
                                    Text("Max \(day.temp.max.roundedString(to: 0))°")
                                    
                                    Text("Min \(day.temp.min.roundedString(to: 0))°")
                                    Image(systemName: day.weather[0].iconImage)
                                        .renderingMode(.original)
                                        .font(.system(size: 25))
                                        .padding(4)
                                    Text("Cloud: \(day.clouds)%")
                                }
                                .padding(.horizontal,5)
                                
//                                VStack {
//                                    Text(daily[0].dt == day.dt ? "Today": day.dt.dayDateMonth)
//                                        .font(.title)
//                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                                    HStack {
//                                        Text("Max \(day.temp.max.roundedString(to: 0))°")
//                                        Divider()
//                                        Divider()
//                                        Text("Min \(day.temp.min.roundedString(to: 0))°")
//                                    }
//                                    Image(systemName: day.weather[0].iconImage)
//                                        .renderingMode(.original)
//                                        .font(.system(size: 25))
//                                        .padding(4)
//                                    HStack {
//                                        Text("Rain: \((day.pop * 100).roundedString(to: 0))%")
//                                        Divider()
//                                        Divider()
//                                        Text("Cloud: \(day.clouds)%")
//                                    }
//                                }.padding()
                            }
                           
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                        }
                    }
                //}
            }.padding(.horizontal,8)
        }
    }
}

