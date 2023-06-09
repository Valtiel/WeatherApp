//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by César Rosales on 06/05/2023.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWeatherViewModel_whenInitialized_shouldHaveEmptyValues() {
        let mockService = WeatherServiceFactory.createService(for: .mock)
        let mockCity = City.name("Mock")
        let viewModel = CityWeatherViewModel(weatherService: mockService, city: mockCity)
        
        XCTAssertEqual(viewModel.temperature, "")
        XCTAssertEqual(viewModel.humidity, "")
        XCTAssertEqual(viewModel.cityName, "")
        XCTAssertEqual(viewModel.conditionDescription, "")
        XCTAssertEqual(viewModel.feelsLikeTemperature, "")

    }
    
    func testWeatherViewModel_whenWeatherDataReceived_shouldUpdateValues() {

    }
    
    func testWeatherViewModel_whenInvalidWeatherDataReceived_shouldNotUpdateValues() {

    }
    
}
