//
//  MockConfigurationService.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

class MockConfigurationService: ConfigurationService {
    
    func getData() -> AppConfiguration {
        let mockData = AppConfiguration(cities: ["miami", "caracas", "mock"], apiKey: "", weatherService: "mock")
        return mockData
    }
    
}
