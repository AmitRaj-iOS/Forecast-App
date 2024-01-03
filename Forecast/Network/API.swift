//
//  API.swift
//  Forecast
//
//  Created by Amit Swiift on 03/01/24.
//

import Foundation

struct API {
    static let key = "6b0f9abfd032ccca32d2eba6fab78445"
    
    static func checkForAPIKey() {
        precondition(API.key != "f2ba36753f590e84769927522580b06b", "Condition: \nEither your APIKey is invalid or you haven't filled it yet. \nPlease Fill Your APIKey")
    }
}
