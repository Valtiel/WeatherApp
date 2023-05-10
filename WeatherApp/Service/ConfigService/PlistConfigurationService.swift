//
//  PlistConfigurationService.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

class PlistConfigurationService: ConfigurationService {
    
    func getData() -> AppConfiguration {
        
        let cities = PlistAppConfiguration.getCities()
        let apiKey = PlistAppConfiguration.getApiKey()
        let weatherService = PlistAppConfiguration.getWeatherService()
        
        let data = AppConfiguration(cities: cities, apiKey: apiKey, weatherService: weatherService)
        return data
    }

}
