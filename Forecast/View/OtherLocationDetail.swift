//
//  OtherLocationDetail.swift
//  Forecast
//
//  Created by Amit Swiift on 04/01/24.
//

import SwiftUI

struct OtherLocationDetail: View {
    @StateObject var weatherVM = WeatherViewModel()
    var body: some View {
        VStack{
            SearchView(weatherVM: weatherVM)
            ScrollView(showsIndicators: false) {
                DailyView(weatherVM: weatherVM)
            }
           
        }
      
    }
}

struct OtherLocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        OtherLocationDetail()
    }
}
