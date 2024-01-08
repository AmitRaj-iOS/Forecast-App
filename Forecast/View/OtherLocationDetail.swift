//
//  OtherLocationDetail.swift
//  Forecast
//
//  Created by Amit Swiift on 04/01/24.
//

import SwiftUI

struct OtherLocationDetail: View {
    
    // MARK: - Property
    @StateObject var weatherVM = WeatherViewModel()
    @State var isSearchData = false
    @State var isshowAlert = false
    
    // MARK: - Body
    var body: some View {

        ZStack{
            BackgroundView()
            VStack{
                // MARK: - SeacrhView 
                HStack {
                    TextField("Search City", text: $weatherVM.searchedCityName, onCommit:  {
                    weatherVM.fetchWeatherByCityName()
                    })
                    .padding(5)
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(8)
                    Button {
                        if  weatherVM.searchedCityName.isEmpty {
                        } else {
                            weatherVM.fetchWeatherByCityName()
                            hideKeyboard()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.isSearchData = true
                                weatherVM.searchedCityName = ""
                            }
                        }
                    } label: {
                        Image(systemName: "magnifyingglass").renderingMode(.original)
                            .font(.system(size: 24))
                    }
                }
                .padding(.horizontal)
                Spacer()
                    if isSearchData == true {
                        
                        //MARK: -  Shows the Current Temp
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
                            //MARK: - Daily Forcast View
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
        
        //MARK: - Alert will show if there is invalid city
        .alert(item: $weatherVM.appError) { (appAlert) in
            Alert(title: Text("Error"), message: Text(
                    """
            \(appAlert.errorString)
            Please try with valid city.
            """)
            )
        }
    }
}

struct OtherLocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        OtherLocationDetail()
    }
}

