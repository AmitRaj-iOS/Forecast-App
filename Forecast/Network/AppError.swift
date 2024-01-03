//
//  AppError.swift
//  Forecast
//
//  Created by Amit Swiift on 03/01/24.
//

import Foundation
struct AppError: Identifiable {
    
    // MARK: - Properties
    let id = UUID().uuidString
    let errorString: String
}
