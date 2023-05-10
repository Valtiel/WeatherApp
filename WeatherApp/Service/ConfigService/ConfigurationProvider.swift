//
//  ConfigurationProvider.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

class ConfigurationProvider: ObservableObject {
    
  @Published private(set) var config: AppConfiguration
    
  private let service: ConfigurationService
    
  init(service: ConfigurationService) {
    self.service = service
    config = service.getData() 
  }
    
}
