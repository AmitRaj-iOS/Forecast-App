//
//  UIAppExtension.swift
//  Forecast
//
//  Created by Amit Swiift on 03/01/24.
//

import Foundation

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
#endif
