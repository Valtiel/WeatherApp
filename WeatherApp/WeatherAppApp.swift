//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by César Rosales on 06/05/2023.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    let configProvider = ConfigurationProvider(service: PlistConfigurationService())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(configProvider)
        }
    }
}
