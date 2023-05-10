//
//  MockWeatherService.swift
//  WeatherApp
//
//  Created by César Rosales on 06/05/2023.
//

import Foundation

class MockWeatherService: WeatherService {

    let mockData = WeatherData(cityName: "New York", country: "US", temperature: 15.0, feelsLikeTemperature: 12.0, minTemperature: 10.0, maxTemperature: 18.0, windSpeed: 10.0, windDirection: 180, pressure: 1013, humidity: 70, visibility: 10000, description: "Sunny", icon: "01d")
    
    func getWeatherData(for code: String,
                        completion: @escaping (Result<WeatherData, Error>) -> Void) {
        completion(.success(mockData))
    }
    
    func getWeatherDataWithCoordinates(lat: Double,
                                       lon: Double,
                                       completion: @escaping (Result<WeatherData, Error>) -> Void) {
        completion(.success(mockData))
    }
    
}
