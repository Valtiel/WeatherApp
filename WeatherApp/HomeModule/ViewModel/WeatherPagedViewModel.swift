//
//  WeatherPagedViewModel.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

class WeatherPagedViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var cities: [CityWeatherViewModel]
    
    init(cities: [CityWeatherViewModel]) {
        self.cities = cities
    }
    
}
