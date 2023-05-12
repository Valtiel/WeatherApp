//
//  CityWeatherView.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import SwiftUI

struct CityWeatherView: View {
    
    @ObservedObject var viewModel: CityWeatherViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loaded:
                TopBarView(city: viewModel.cityName, country: viewModel.countryName, action: viewModel.fetchWeatherData)
                
                HeaderCardView(temperature: viewModel.temperature, description: viewModel.conditionDescription, feelsLike: viewModel.feelsLikeTemperature)
                    .transition(.move(edge: .top))
                    .animation(.easeInOut(duration: 0.2))
                HStack {
                    
                }
                ForecastCardView(minTemperature: viewModel.minTemperature, maxTemperature: viewModel.maxTemperature)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.2))
                
                WindConditionsCardView(windSpeed: viewModel.windSpeed, windDirection: viewModel.windDirection)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.2))
     
            case .idle:
                LoadingView()
            case .loading:
                LoadingView()
            case .failed(let error):
                ErrorView(error: error, action: viewModel.fetchWeatherData)
            }
            
        }.onAppear {
            if viewModel.state.needsLoading() {
                viewModel.fetchWeatherData()
            }
        }
        
    }
}

struct ErrorView: View {
    
    var error: Error
    var action: () -> Void
    
    var body: some View {
        VStack{
            HStack {
                Text("Oops!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Button(action: action, label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }).foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .padding()
                    .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                
            }.frame(maxWidth: .infinity, alignment: .center)
        }
        Text("Something went wrong, please try again")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
        
    }
}

struct LoadingView: View {
    var body: some View {
        Spacer()
        ProgressView("Updating data")
            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            .font(.headline)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        Spacer()
    }
}

struct TopBarView: View {
    
    var city: String
    var country: String
    var action: () -> Void

    var body: some View {
        VStack {
            HStack {
                Text("\(city) (\(country))")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Button(action: action, label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }).foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .padding()
                    .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                
            }.frame(maxWidth: .infinity, alignment: .center)
        }
        
    }
}

struct HeaderCardView: View {
    
    @State var temperature: Float
    @State var description: String
    @State var feelsLike: Float
    
    var body: some View {
        VStack {
                Text("\(description)")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(String(format: "%.0f°", temperature))")
                    .font(.system(size: 80))
                    .bold()
                    .foregroundColor(.white)
                Text("Feels like \(String(format: "%.0f°", feelsLike))")
                    .foregroundColor(.white)
                    .font(.headline)
        }        .frame(maxWidth: .infinity, alignment: .center)
        
    }
}

struct ForecastCardView: View {
    
    @State var minTemperature: Float
    @State var maxTemperature: Float
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Forecast")
                    .font(.headline)
                    .foregroundColor(.white)
                Group {
                    
                    Text("Min: \(String(format: "%.0f°", minTemperature)) - Max: \(String(format: "%.0f°", maxTemperature))")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                }
                .padding([.horizontal], 20)
            }
            .padding(.all, 10)
        }.frame(minWidth: 40, maxWidth: .infinity,
                alignment: .leading)
            .background(
                Color.black.opacity(0.2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding(.all, 10)
        
    }
}

struct WindConditionsCardView: View {
    
    @State var windSpeed: Float
    @State var windDirection: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Wind Conditions")
                    .font(.headline)
                    .foregroundColor(.white)
                Group {
                    
                    Text("Wind Speed: \(String(format: "%.1f m/s", windSpeed))")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Wind Direction: \(windDirection)")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                }
                .padding([.horizontal], 20)
            }
            .padding(.all, 10)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Color.black.opacity(0.2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding(.all, 10)
        
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        
        let mockViewModel = CityWeatherViewModel(weatherService: WeatherServiceFactory.createService(for: .mock), city: City.name(""))
        CityWeatherView(viewModel: mockViewModel)
            .background(Color.blue)
        
        
    }
}
