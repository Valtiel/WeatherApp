//
//  WeatherPagedView.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import SwiftUI

struct WeatherPagedView: View {
    
    var cities: [CityWeatherViewModel]
    
    var body: some View {
        VStack {
            TabView {
                ForEach(cities, id: \.city) { cityDetailViewModel in
                    VStack {
                        CityWeatherView(viewModel: cityDetailViewModel)
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page)
        }
        
    }
    
}

struct WeatherPagedView_Previews: PreviewProvider {
    static var previews: some View {
        
        let mockViewModel = CityWeatherViewModel(weatherService: WeatherServiceFactory.createService(for: .mock), city: City.name("mock"))
        
        let mockViewModelB = CityWeatherViewModel(weatherService: WeatherServiceFactory.createService(for: .mock), city: City.name("mock"))
        
        WeatherPagedView(cities:[mockViewModel, mockViewModelB])
            .background(Color.blue)
    }
}
