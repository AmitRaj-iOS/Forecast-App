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
                    ZStack{
                        BackgroundView()
                        ScrollView(showsIndicators: false) {
                            VStack {
                                CurrentView(weatherVM: weatherVM)
                                NavigationLink(destination: OtherLocationDetail()) {
                                    HStack{
                                        Image(systemName: "location.fill")
                                        Text("Click Here for More Location")
                                            .foregroundColor(Color.blue)
                                            .padding(5)
                                    }
                                    .padding(8)
                                    .background(Color("AppBlue"))
                                    .cornerRadius(10)
                                }
                                DetailView(weatherVM: weatherVM)
                                DailyView(weatherVM: weatherVM)
                            }
                        }
                    }
                    .navigationBarTitle("What's the weather like today", displayMode: .inline)
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



