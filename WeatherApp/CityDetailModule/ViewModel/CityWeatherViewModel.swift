//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

class CityWeatherViewModel: ObservableObject {
    
    enum State {
        
        case idle
        case loading
        case failed(Error)
        case loaded
        
        func needsLoading() -> Bool {
            switch self {
            case .idle:
                return true
            case .failed(_):
                return true
            default:
                return false
            }
        }
        
    }
    
    @Published private(set) var state: State = State.idle
    @Published private(set) var cityName: String = ""
    
    @Published private(set) var countryName: String = ""
    @Published private(set) var temperature: Float = .nan
    @Published private(set) var conditionDescription: String = ""
    @Published private(set) var conditionIconName: String = ""
    @Published private(set) var minTemperature: Float = .nan
    @Published private(set) var maxTemperature: Float = .nan
    @Published private(set) var feelsLikeTemperature: Float = .nan
    @Published private(set) var windSpeed: Float = .nan
    @Published private(set) var windDirection: String = ""
    @Published private(set) var pressure: String = ""
    @Published private(set) var humidity: String = ""
    @Published private(set) var visibility: String = ""
    
    private let weatherService: WeatherService
    let city: City
        
    init(weatherService: WeatherService, city: City) {
        self.weatherService = weatherService
        self.city = city
    }
    
    func fetchWeatherData() {
        
        switch city {
        case .name(let name):
            fetchWeatherData(cityName: name)
        case .location(let lat, let lon):
            fetchWeatherData(lat: lat, lon: lon)
        }

    }
    
    func fetchWeatherData(lat: Double, lon: Double) {
        self.state = State.loading
        weatherService.getWeatherDataWithCoordinates(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.cityName = weatherData.cityName
                    self.countryName = weatherData.country
                    self.temperature = weatherData.temperature
                    self.conditionDescription = weatherData.description
                    self.conditionIconName = weatherData.icon
                    self.windSpeed = weatherData.windSpeed
                    self.windDirection = self.formatWindDirection(weatherData.windDirection)
                    self.pressure = weatherData.formattedPressure
                    self.humidity = weatherData.formattedHumidity
                    self.visibility = weatherData.formattedVisibility
                    self.feelsLikeTemperature = weatherData.feelsLikeTemperature
                    self.minTemperature = weatherData.minTemperature
                    self.maxTemperature = weatherData.maxTemperature
                    self.state = State.loaded
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.state = State.failed(error)
            }
        }
    }
    
    func fetchWeatherData(cityName: String) {
        self.state = State.loading
        weatherService.getWeatherData(for: cityName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.cityName = weatherData.cityName
                    self.countryName = weatherData.country
                    self.temperature = weatherData.temperature
                    self.conditionDescription = weatherData.description
                    self.conditionIconName = weatherData.icon
                    self.windSpeed = weatherData.windSpeed
                    self.windDirection = self.formatWindDirection(weatherData.windDirection)
                    self.pressure = weatherData.formattedPressure
                    self.humidity = weatherData.formattedHumidity
                    self.visibility = weatherData.formattedVisibility
                    self.feelsLikeTemperature = weatherData.feelsLikeTemperature
                    self.minTemperature = weatherData.minTemperature
                    self.maxTemperature = weatherData.maxTemperature
                    self.state = State.loaded
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.state = State.failed(error)
            }
        }
    }
}

// MARK: DATA FORMAT FUNCTIONS
private extension CityWeatherViewModel {
    
    func formatWindDirection(_ direction: Int) -> String {
        let directions = ["North", "NorthEast", "East", "SouthEast", "South", "SouthWest", "West", "NorthWest"]
        let index = Int((direction + 22) / 45) % 8
        return directions[index]
    }
    
}
