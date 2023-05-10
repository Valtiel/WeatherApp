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
                    HeaderCardView(viewModel: viewModel)
                        .transition(.move(edge: .top))
                        .animation(.easeInOut(duration: 0.2))
                    WindConditionsCardView(viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.2))
                    ForecastCardView(viewModel: viewModel)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.2))
            case .idle:
                LoadingView()
            case .loading:
                LoadingView()
            case .failed(let error):
                ErrorView(error: error
                , viewModel: viewModel)
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
    @ObservedObject var viewModel: CityWeatherViewModel

    var body: some View {
        VStack{
            HStack {
                Text("Oops!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Button {
                    viewModel.fetchWeatherData()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }.foregroundColor(Color.white)
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

struct HeaderCardView: View {
    
    @ObservedObject var viewModel: CityWeatherViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.cityName) (\(viewModel.countryName))")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Button {
                    viewModel.fetchWeatherData()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }.foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .padding()
                    .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                
            }.frame(maxWidth: .infinity, alignment: .center)
            
            
            
            
            Group {
                Text("\(viewModel.conditionDescription)")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(viewModel.temperature)
                    .font(.system(size: 80))
                    .bold()
                    .foregroundColor(.white)

                Text("Feels like \(viewModel.feelsLikeTemperature)")
                    .foregroundColor(.white)
                    .font(.headline)
                
                
            }
        }        .frame(maxWidth: .infinity, alignment: .center)
        
        
        
    }
}

struct ForecastCardView: View {
    
    @ObservedObject var viewModel: CityWeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Forecast")
                    .font(.headline)
                    .foregroundColor(.white)
                Group {
                    
                    Text("Min: \(viewModel.minTemperature) - Max: \(viewModel.maxTemperature)")
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

struct WindConditionsCardView: View {
    
    @ObservedObject var viewModel: CityWeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Wind Conditions")
                    .font(.headline)
                    .foregroundColor(.white)
                Group {
                    
                    Text("Wind Speed: \(viewModel.windSpeed)")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Wind Direction: \(viewModel.windDirection)")
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
