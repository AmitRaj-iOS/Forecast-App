//
//  Coordinate.swift
//  Forecast
//
//  Created by Amit Swiift on 01/01/24.
//

import Foundation


struct  Coordinate: Codable {
    let lon, lat : Double
    static func emptyInit() -> Coordinate {
        return Coordinate(lon: 0, lat: 0)
    }
}
