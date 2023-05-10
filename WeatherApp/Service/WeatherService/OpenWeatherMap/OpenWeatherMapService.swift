//
//  OpenWeatherMapService.swift
//  WeatherApp
//
//  Created by César Rosales on 06/05/2023.
//

import Foundation

class OpenWeatherMapService: WeatherService {

    private let apiKey: String
    private let baseUrl: String = "https://api.openweathermap.org"
    private let path: String = "/data/2.5/weather"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func getWeatherDataWithCoordinates(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let baseUrl = WeatherServiceBuilder(baseUrl: baseUrl, path: path)

        let url = baseUrl
            .addQueryItem(name: "lat", value: String(format: "%f", lat))
            .addQueryItem(name: "lon", value: String(format: "%f", lon))
            .addQueryItem(name: "units", value: "metric")
            .addQueryItem(name: "appid", value: apiKey)
            .build()
        
        URLSession.shared.dataTask(with: url) { [unowned self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(WeatherServiceError.apiError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(WeatherServiceError.invalidResponse))
                return
            }
            
            do {
                let weatherData = try self.decodeResponse(data: data)
                
                completion(.success(weatherData))
            } catch {
                completion(.failure(WeatherServiceError.invalidData))
            }
        }.resume()
    }
    
    
    func getWeatherData(for code: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let baseUrl = WeatherServiceBuilder(baseUrl: baseUrl, path: path)

        let url = baseUrl
            .addQueryItem(name: "q", value: code)
            .addQueryItem(name: "units", value: "metric")
            .addQueryItem(name: "appid", value: apiKey)
            .build()
        
        URLSession(configuration: .default).dataTask(with: url) { [unowned self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(WeatherServiceError.apiError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(WeatherServiceError.invalidResponse))
                return
            }
            
            do {
                let weatherData = try self.decodeResponse(data: data)
                
                completion(.success(weatherData))
            } catch {
                completion(.failure(WeatherServiceError.invalidData))
            }
        }.resume()
    }
    
    private func decodeResponse(data: Data) throws -> WeatherData {
        let response = try JSONDecoder().decode(OpenWeatherMapAPIResponse.self, from: data)
        guard let weather = response.weather.first else {
            throw WeatherServiceError.invalidData
        }
        
        let temperature = response.main.temp
        let minTemperature = response.main.tempMin
        let maxTemperature = response.main.tempMax
        let humidity = response.main.humidity
        let weatherDescription = weather.description
        let windSpeed = response.wind.speed
        let windDirection = response.wind.deg
        let visibility = response.visibility
        let name = response.name
        let country = response.sys.country
        let feelsLikeTemperature = response.main.feelsLike
        let pressure = response.main.pressure

        let weatherData = WeatherData(cityName: name, country: country, temperature: temperature, feelsLikeTemperature: feelsLikeTemperature, minTemperature: minTemperature, maxTemperature: maxTemperature, windSpeed: windSpeed, windDirection: windDirection, pressure: pressure, humidity: humidity, visibility: visibility, description: weatherDescription, icon: "01d")

        
        return weatherData
    }
}

private class WeatherServiceBuilder {
    private let baseUrl: String
    private var path: String
    private var queryItems: [URLQueryItem] = []
    
    init(baseUrl: String, path: String) {
        self.baseUrl = baseUrl
        self.path = path
    }
    
    func addQueryItem(name: String, value: String) -> WeatherServiceBuilder {
        queryItems.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    func build() -> URL {
        var components = URLComponents(string: baseUrl)!
        components.path = path
        components.queryItems = queryItems
        return components.url!
    }
}
