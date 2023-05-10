//
//  WeatherServiceFactory.swift
//  WeatherApp
//
//  Created by César Rosales on 06/05/2023.
//

import Foundation

class WeatherServiceFactory {
    
    static func createService(for type: String, apiKey: String) -> WeatherService? {
        switch type {
        case "OpenWeatherMap":
            return WeatherServiceFactory.createService(for: .openWeatherMap(apiKey: apiKey))
        case "mock":
            return WeatherServiceFactory.createService(for: .mock)
        default:
            return nil
        }
    }
    
    static func createService(for type: WeatherServiceType) -> WeatherService {
        return type.getService()
    }
}

enum WeatherServiceType {
    case openWeatherMap(apiKey: String)
    case mock
    
    func getService() -> WeatherService {
        switch self {
        case .openWeatherMap(let apiKey):
            return OpenWeatherMapService(apiKey: apiKey)
        case .mock:
            return MockWeatherService()
        }
    }
}
