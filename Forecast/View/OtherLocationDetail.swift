//
//  OtherLocationDetail.swift
//  Forecast
//
//  Created by Amit Swiift on 04/01/24.
//

import SwiftUI

struct OtherLocationDetail: View {
    @StateObject var weatherVM = WeatherViewModel()
    @State var isSearchData = false
    
    var body: some View {
        
        ZStack{
            BackgroundView()
            VStack{
                
                HStack {
                    Button {
                        weatherVM.getWeather()
                    } label: {
                        Image(systemName: "location.circle.fill").renderingMode(.original)
                            .font(.system(size: 24))
                    }
                    
                    TextField("Search City", text: $weatherVM.searchedCityName, onCommit:  {
                        weatherVM.fetchWeatherByCityName()
                    })
                    .padding(5)
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(8)
                    Button {
                        weatherVM.fetchWeatherByCityName()
                        hideKeyboard()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isSearchData = true
                            weatherVM.searchedCityName = ""
                        }
                        
                    } label: {
                        Image(systemName: "magnifyingglass").renderingMode(.original)
                            .font(.system(size: 24))
                    }
                }
                .padding(.horizontal)
                Spacer()
                if let errorMessage = weatherVM.appError {
                    VStack{
                        Text("Oops! \(errorMessage.errorString)")
                            .foregroundColor(.gray)
                            .font(.title2)
                        
                        Image(systemName: "sun.max.trianglebadge.exclamationmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200,height: 200)
                            .foregroundColor(.gray)
                        
                    }
                    .padding()
                 Spacer()
                } else {
                    if isSearchData == true {
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
                        ScrollView(showsIndicators: false) {
                            DailyView(weatherVM: weatherVM)
                        }
                    } else {
                        Text("Please type city name to get the weather location")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct OtherLocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        OtherLocationDetail()
    }
}

