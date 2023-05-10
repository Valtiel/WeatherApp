//
//  BuildConfiguration.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

enum ConfigurationKey: String {
    case ServerURL = "Server URL"
    case WeatherService = "Weather Service"
    case ApiKey = "API Key"
    case Cities = "Cities"
}

struct PlistAppConfiguration {
    
    static let mainPlistPath = Bundle.main.path(forResource: "Configuration", ofType: "plist")
    
    static func getValue(for key: String) -> String? {
        guard let path = PlistAppConfiguration.mainPlistPath,
              let resourceFileDictionary = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        return resourceFileDictionary[key] as? String
    }
}

extension PlistAppConfiguration {
    
    static func getServerURL() -> String {
        return getValue(for: ConfigurationKey.ServerURL.rawValue)!
    }
    
    static func getWeatherService() -> String {
        return getValue(for: ConfigurationKey.WeatherService.rawValue)!
    }
    
    static func getApiKey() -> String {
        return getValue(for: ConfigurationKey.ApiKey.rawValue)!
    }
    
    static func getCities() -> [String] {
        var cities = getValue(for: ConfigurationKey.Cities.rawValue)!
        cities.removeAll(where: { ["]", "[", "\"", " "].contains($0) })
        return cities.split(separator: ",").compactMap{ String($0) }
    }

}
