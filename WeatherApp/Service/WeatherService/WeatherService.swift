//
//  WeatherService.swift
//  WeatherApp
//
//  Created by César Rosales on 06/05/2023.
//

import Foundation

protocol WeatherService {
    func getWeatherData(for code: String, completion: @escaping (Result<WeatherData, Error>) -> Void)
    func getWeatherDataWithCoordinates(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void)
}

struct WeatherData {
    let cityName: String
    let country: String
    let temperature: Float
    let feelsLikeTemperature: Float
    let minTemperature: Float
    let maxTemperature: Float
    let windSpeed: Float
    let windDirection: Int
    let pressure: Int
    let humidity: Int
    let visibility: Int?
    let description: String
    let icon: String
    
    var formattedTemperature: String {
        return String(format: "%.0f°", temperature)
    }
    
    var formattedFeelsLikeTemperature: String {
        return String(format: "%.0f°", feelsLikeTemperature)
    }
    
    var formattedMinTemperature: String {
        return String(format: "%.0f°", minTemperature)
    }
    
    var formattedMaxTemperature: String {
        return String(format: "%.0f°", maxTemperature)
    }
    
    var formattedWindSpeed: String {
        return String(format: "%.1f m/s", windSpeed)
    }
    
    var formattedPressure: String {
        return String(format: "%.0f hPa", pressure)
    }
    
    var formattedHumidity: String {
        return String(format: "%.0f%%", humidity)
    }
    
    var formattedVisibility: String {
        guard let visibility = visibility else {
            return "N/A"
        }
        return String(format: "%.0f m", visibility)
    }
}

enum WeatherServiceError: Error {
    case invalidResponse
    case apiError
    case invalidData
}

