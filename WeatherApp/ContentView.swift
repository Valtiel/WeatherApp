//
//  ContentView.swift
//  WeatherApp
//
//  Created by César Rosales on 06/05/2023.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @EnvironmentObject var configProvider: ConfigurationProvider
    @StateObject var locationService = LocationService()

    var body: some View {
        VStack {
            if let weatherService = WeatherServiceFactory.createService(for: configProvider.config.weatherService, apiKey: configProvider.config.apiKey) {
                let cities = configProvider.config.cities
                let viewModels: [CityWeatherViewModel] = cities.compactMap {
                    if $0 == "current" {
                        if let latitude = locationService.location?.coordinate.latitude,
                           let longitude = locationService.location?.coordinate.longitude {
                            return CityWeatherViewModel(weatherService: weatherService, city: City.location( lat: latitude, lon: longitude))
                        } else {
                            return nil
                        }
                    } else {
                        return CityWeatherViewModel(weatherService: weatherService, city: City.name($0))
                    }
                }
                WeatherPagedView(cities: viewModels)
            } else {
                Text("ERROR")
            }
            Spacer()
        }
        .background(Color.blue)
        .frame(maxWidth: .infinity, alignment: .leading)

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ConfigurationProvider(service: MockConfigurationService()))
    }
}
