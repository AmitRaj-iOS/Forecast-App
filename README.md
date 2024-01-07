# **🌦** iOS Forecast App  with SwiftUI
![Simulator Screenshot - iPhone 14 Pro - 2024-01-07 at 23 20 52](https://github.com/AmitRaj-iOS/Forecast-App/assets/94159438/b574d0b2-9a33-4b5f-a61a-83d383afbd25)

https://dent-receipt-4e6.notion.site/Task-Documentation-898ad2cc61c44475b1b2e46ea3ebb1c8?pvs=4


## **🔥** Overview

iOS Feature is inspired design from `Apple Weather App` uses [Openweathermap API](https://openweathermap.org/api) and build with SwiftUI. Feature this app same with apple weather like get current weather & details, and get daily forecast.

 But detail not fully same because limited feature free plan from Openweathermap API.

The SwiftUI Weather App is a simple application that provides users with current weather information and a 5-day forecast for a specified location. 

The app leverages SwiftUI for its user interface.

### **🎮** Technologies Used

- SwiftUI
- JSON & Codable
- MVVM design pattern
- ObservableObject
- API Services foe JSON Decoding
- OpenWeatherMap API

### **🛠** Prerequisites

- A valid API key from Openweathermap
- A Mac running macOS Ventura
- Xcode 14.1

## **🌈 Features**

- **SwiftUI:** The user interface of the app is created entirely using SwiftUI, offering a native and responsive user experience on iOS devices.
- **MVVM Architecture:** The project is organized using the Model-View-ViewModel architectural pattern, promoting separation of concerns and maintainability.
- **JSON Data:** Weather data is fetched from the OpenWeatherMap API in JSON format and then decoded into Swift objects for presentation.
- **5-Day Forecast**: The app displays a 5-day weather forecast, showing conditions for each day at 3-hour intervals. This detailed forecast allows users to prepare for various weather changes throughout the day.
- **Temperature in Celsius**: The temperature is presented in Celsius, providing a common and widely used metric for weather-related information.
- **Location Services**: Core Location, a framework in iOS, is employed to determine the longitude and latitude of the user's current location. This ensures that the app can provide weather information tailored to the user's vicinity.
- **API Integration**: The app fetches weather data from the OpenWeatherMap API ([https://api.openweathermap.org](https://api.openweathermap.org/)). This API provides real-time and accurate weather information, enabling the app to present reliable forecasts to users
- **Current Weather View:** Displays the current temperature and weather description for the user's current locations.Fetches weather data using the WeatherService.
- **Forecast Search View:** Allows users to enter a location (city name) to get a 5-day weather forecast.Displays the temperature and weather description for each day.

### **🏄‍♂️** Getting Started

1. Clone the repository to your local computer.
2. Open the Xcode project.
3. Build and run the app on your iOS device or simulator
