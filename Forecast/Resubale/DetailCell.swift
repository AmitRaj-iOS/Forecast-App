//
//  DetailCell.swift
//  Forecast
//
//  Created by Amit Swiift on 03/01/24.
//


import SwiftUI

struct DetailCell: View {
    
    // MARK: - Properties
    let title: String
    let detail: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.body).fontWeight(.light)
            Text(detail).bold()
        }
        Divider()
    }
}
