//
//  ContentView.swift
//  Forecast
//
//  Created by Amit Swiift on 01/01/24.
//


import SwiftUI

struct ContentView: View {
    
    // MARK: - Property
    @StateObject var weatherVM = WeatherViewModel()
    
    // MARK: - Body
    var body: some View {
        if weatherVM.isLoading {
            ProgressView("Loading").font(.title3)
        } else {
            NavigationView {
               
                
                 
                    ScrollView(showsIndicators: false) {
                        VStack {
                            // SearchView(weatherVM: weatherVM)
                            CurrentView(weatherVM: weatherVM)
                            NavigationLink(destination: OtherLocationDetail()) {
                                Text("Click Here for More Location")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(10)
                                    .padding(5)
                            }
                            DetailView(weatherVM: weatherVM)
                            ScrollView(showsIndicators: false) {
                                DailyView(weatherVM: weatherVM)
                                //HourlyView(weatherVM: weatherVM)
                                
                            }
                        }
                    }
                
                    .background(Image("bgPic").resizable().scaledToFill())
                     
                                
                    }
                    .animation(.easeInOut(duration: 1))
              
          
        }
    }
}

// MARK: - Content Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







//struct ContentView: View {
//    @StateObject private var weatherViewModel = WeatherViewModel()
//
//    var body: some View {
//        VStack {
//            if let currentWeather = weatherViewModel.currentWeather {
//                Text("Current Temperature: \(currentWeather.main.temp)°C")
//            } else {
//                Text("Fetching data...")
//            }
//
//            if let forecast = weatherViewModel.fiveDayForecast {
//                ForEach(forecast.list) { forecastItem in
//                    Text("\(forecastItem.dt_txt): \(forecastItem.main.temp)°C")
//                }
//            } else {
//                Text("Fetching forecast...")
//            }
//        }
//        .onAppear {
//            weatherViewModel.getLocation()
//            weatherViewModel.fetchWeather()
//            weatherViewModel.fetchFiveDayForecast()
//        }
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//class WeatherViewModel: ObservableObject {
//    @Published var currentWeather: CurrentWeather?
//    @Published var fiveDayForecast: FiveDayForecast?
//
//    private var locationManager = CLLocationManager()
//
//    func getLocation() {
//        locationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    func fetchWeather() {
//        guard let location = locationManager.location else { return }
//        let apiKey = "f2ba36753f590e84769927522580b06b"
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)"
//
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data {
//                    do {
//                        let decodedData = try JSONDecoder().decode(CurrentWeather.self, from: data)
//                        DispatchQueue.main.async {
//                            self.currentWeather = decodedData
//                        }
//                    } catch {
//                        print(error)
//                    }
//                }
//            }.resume()
//        }
//    }
//
//    func fetchFiveDayForecast() {
//        guard let location = locationManager.location else { return }
//        let apiKey = "f2ba36753f590e84769927522580b06b"
//        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)"
//
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data {
//                    do {
//                        let decodedData = try JSONDecoder().decode(FiveDayForecast.self, from: data)
//                        DispatchQueue.main.async {
//                            self.fiveDayForecast = decodedData
//                        }
//                    } catch {
//                        print(error)
//                    }
//                }
//            }.resume()
//        }
//    }
//}
//
//extension WeatherViewModel: CLLocationManagerDelegate {
//
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error.localizedDescription)
//    }
//}
//
//struct CurrentWeather: Decodable {
//    let main: Main
//}
//
//struct Main: Decodable {
//    let temp: Double
//}
//
//struct FiveDayForecast: Decodable,Identifiable {
//    var id = UUID()
//
//    let list: [ForecastItem]
//}
//
//struct ForecastItem: Decodable {
//    let dt_txt: String
//    let main: Main
//}
