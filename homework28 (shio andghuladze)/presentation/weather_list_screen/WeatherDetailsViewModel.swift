//
//  WeatherDetailsViewModel.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import Foundation

class WeatherDetailsViewModel{
    private let weatherRepository = WeatherRepositoryImpl.getInstance()

    func getCountryWeather(country: Country?, onResponse: @escaping (WeatherInfo)-> Void){
        Task{
            guard let lat = country?.latlng?[0] else {
                return
            }
            guard let lon = country?.latlng?[1] else {
                return
            }
            let response = await weatherRepository.getWeather(lat: lat, lon: lon)
            NetworkManager.parseResponse(response: response) { weatherInfo in
                onResponse(weatherInfo)
            }
        }
    }
}
