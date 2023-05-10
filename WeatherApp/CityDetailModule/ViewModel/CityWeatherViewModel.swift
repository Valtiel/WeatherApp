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
    @Published private(set) var temperature: String = ""
    @Published private(set) var conditionDescription: String = ""
    @Published private(set) var conditionIconName: String = ""
    @Published private(set) var minTemperature: String = ""
    @Published private(set) var maxTemperature: String = ""
    @Published private(set) var feelsLikeTemperature: String = ""
    @Published private(set) var windSpeed: String = ""
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
                    self.temperature = "\(weatherData.formattedTemperature)"
                    self.conditionDescription = weatherData.description
                    self.conditionIconName = weatherData.icon
                    self.windSpeed = weatherData.formattedWindSpeed
                    self.windDirection = weatherData.formattedWindDirection
                    self.pressure = weatherData.formattedPressure
                    self.humidity = weatherData.formattedHumidity
                    self.visibility = weatherData.formattedVisibility
                    self.feelsLikeTemperature = weatherData.formattedFeelsLikeTemperature
                    self.minTemperature = weatherData.formattedMinTemperature
                    self.maxTemperature = weatherData.formattedMaxTemperature
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
                    self.temperature = "\(weatherData.formattedTemperature)"
                    self.conditionDescription = weatherData.description
                    self.conditionIconName = weatherData.icon
                    self.windSpeed = weatherData.formattedWindSpeed
                    self.windDirection = weatherData.formattedWindDirection
                    self.pressure = weatherData.formattedPressure
                    self.humidity = weatherData.formattedHumidity
                    self.visibility = weatherData.formattedVisibility
                    self.feelsLikeTemperature = weatherData.formattedFeelsLikeTemperature
                    self.minTemperature = weatherData.formattedMinTemperature
                    self.maxTemperature = weatherData.formattedMaxTemperature
                    self.state = State.loaded
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.state = State.failed(error)
            }
        }
    }
}
