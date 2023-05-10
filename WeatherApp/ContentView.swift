//
//  ContentView.swift
//  WeatherApp
//
//  Created by César Rosales on 06/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var configProvider: ConfigurationProvider
    @StateObject var locationService = LocationService()

    var body: some View {
        VStack {
            if let weatherService = WeatherServiceFactory.createService(for: configProvider.config.weatherService, apiKey: configProvider.config.apiKey) {
                
                let viewModels: [CityWeatherViewModel] = configProvider.config.cities.map {
                    if $0 == "current" {
                        return CityWeatherViewModel(weatherService: weatherService, city: City.location( lat: locationService.locationManager.location?.coordinate.latitude ?? 0, lon: locationService.locationManager.location?.coordinate.longitude ?? 0))
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
