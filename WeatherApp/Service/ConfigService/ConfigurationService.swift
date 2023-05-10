//
//  ConfigurationService.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

protocol ConfigurationService {

    func getData() -> AppConfiguration
    
}

struct AppConfiguration {
    let cities: [String]
    let apiKey: String
    let weatherService: String
}

enum ConfigurationServiceError: Error {
    case missingData
    case invalidData
}
