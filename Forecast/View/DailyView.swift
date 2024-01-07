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
                VStack {
                    ForEach(daily.prefix(5) , id: \.dt) { day in
                        ZStack {
                            VStack{
                                HStack{
                                    Text(daily[0].dt == day.dt ? "Today": day.dt.dayDateMonth)
                                        .fontWeight(.bold)
                                        .fixedSize()
                                        .frame(minWidth: 100, maxWidth: .infinity, alignment: .leading)
                                    Text("Max \(day.temp.max.roundedString(to: 0))°")
                                        .font(.subheadline)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Rectangle()
                                        .frame(height:2)
                                    Text("Min \(day.temp.min.roundedString(to: 0))°")
                                        .font(.subheadline)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: day.weather[0].iconImage)
                                        .renderingMode(.original)
                                        .font(.system(size: 25))
                                        .padding(4)
                                    
                                }
                                .padding(.horizontal,5)
                                HStack{
                                    Text("Description : \(day.weather[0].description)")
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                        .fixedSize()
                                    Spacer()
                                    Text("Cloud: \(day.clouds)%")
                                        .fixedSize()
                                        .font(.subheadline)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                }
                                Divider()
                            }
                            .padding(.horizontal,5)
                        }
                        
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            }.padding(.horizontal,8)
        }
    }
}


