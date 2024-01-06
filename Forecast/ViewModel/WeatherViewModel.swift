//
//  WeatherViewModel.swift
//  Forecast
//
//  Created by Amit Swiift on 01/01/24.
//



import SwiftUI
import CoreLocation

final class WeatherViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    @Published var showAlert = false
    @Published var isLoading = true
    @Published var appError: AppError? = nil
    
    @Published var searchedCityName = ""
    @Published var currentCityName = ""
    @Published var timeZoneOffset = 0
    
    @Published var current: WeatherDataModel.Current?
    @Published var daily: [WeatherDataModel.Daily]?
    @Published var hourly: [WeatherDataModel.Hourly]?
    
    let apiService = APIService.shared
    let locationManager = CLLocationManager()
    
    // MARK: - Initialization
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        requestLocation()
    }
    
    // MARK: - Class Methods
    func getWeather() {
        if let location = locationManager.location {
            performWeatherRequest(with: location)
        }
    }
    
    func fetchWeatherByCityName() {
        if searchedCityName != "" {
            CLGeocoder().geocodeAddressString(searchedCityName) { (placemarks, error) in
                if let location = placemarks?.first?.location {
                    self.performWeatherRequest(with: location)
                } else {
                    self.appError = AppError(errorString: "\("Invalid")")
                }
            }
        } else {
           
        }
    }
    
    func performWeatherRequest(with location: CLLocation) {
        API.checkForAPIKey()
        let coordinate = location.coordinate
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&exclude=minutely,alerts&appid=\(API.key)&units=metric"
        apiService.getJSON(urlString: urlString) { (result: Result<WeatherDataModel, APIService.APIError>) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async { [weak self] in
                    self?.timeZoneOffset = result.timezone_offset
                    self?.current = result.current
                    self?.daily = result.daily
                    self?.hourly = result.hourly
                    self?.getCityName(of: location)
                    self?.isLoading = false
                    self?.searchedCityName = ""
                }
            case .failure(let apiError):
                print("mansaError: \(apiError.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.appError = AppError(errorString: "\(result)")
                    print(result)
                }
            }
        }
    }
    
    func getCityName(of location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                self.currentCityName = "\(placemark.locality ?? "") \(placemark.country ?? "")"
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocation()
    }
    private func requestLocation() {
        
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else { return }
        }

        switch locationAuthorizationStatus() {
        case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        case .restricted: break
        case .denied: showAlert = true; isLoading = false
        @unknown default: break
        }
    }
    
    func locationAuthorizationStatus() -> CLAuthorizationStatus {
        let locationManager = CLLocationManager()
        var locationAuthorizationStatus : CLAuthorizationStatus
        if #available(macCatalyst 14.0, *), #available(iOS 14.0, *) {
            locationAuthorizationStatus =  locationManager.authorizationStatus
        } else {
            // Fallback on earlier versions
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        return locationAuthorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.isLoading = false
        print(error.localizedDescription)
    }
}


//class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private var locationManager = CLLocationManager()
//    private var cancellables: Set<AnyCancellable> = []
//
//    @Published var weather: Weather?
//
//    override init() {
//        super.init()
//        setupLocationManager()
//    }
//
//    private func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            locationManager.stopUpdatingLocation()
//        }
//    }
//
//    private func fetchWeatherData(latitude: Double, longitude: Double) {
//       // guard let apiKey = Constants.apiKey else { return }
//
//     let apiKey = "f2ba36753f590e84769927522580b06b"
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
//
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTaskPublisher(for: url)
//                .map(\.data)
//                .decode(type: Weather.self, decoder: JSONDecoder())
//                .receive(on: DispatchQueue.main)
//                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] weather in
//                    self?.weather = weather
//                })
//                .store(in: &cancellables)
//        }
//    }
//}
