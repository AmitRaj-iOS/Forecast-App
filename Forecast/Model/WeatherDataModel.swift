//
//  Coordinate.swift
//  Forecast
//
//  Created by Amit Swiift on 01/01/24.
//

import Foundation


//MARK: You can use Codable in Swift to encode and decode custom data formats, such as JSON, to native Swift object
struct WeatherDataModel: Codable {
    let timezone_offset: Int
    let current: Current
    let daily: [Daily]
    let hourly: [Hourly]
    
    // MARK: - Current Weather Model
    struct Current: Codable {
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
        let uvi: Double
        let clouds: Int
        let visibility: Int
        let wind_speed: Double
        let wind_deg: Int
        let weather: [Weather]
    }
    
    // MARK: - Hourly Weather Model
    struct Hourly: Codable {
        let dt: Int
        let temp: Double
        let humidity: Int
        let clouds: Int
        let pop: Double
        let weather: [Weather]
    }
    
    // MARK: - Current Weather Model
    struct Daily: Codable {
        let dt: Int
        let temp: Temp
        let clouds: Int
        let humidity: Int
        let pop: Double
        let weather: [Weather]
        
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
    }
    
    // MARK: - Sub Detail Model
    struct Weather: Codable {
        let description: String
        let icon: String
    }
}





