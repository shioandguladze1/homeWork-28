//
//  WeatherRepository.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import Foundation

protocol WeatherRepository {
    
    func getWeather(lat: Double, lon: Double) async -> NetworkResponse
    
}

actor WeatherRepositoryImpl: WeatherRepository{
    
    static func getInstance()-> WeatherRepository {
        return WeatherRepositoryImpl()
    }
    
    func getWeather(lat: Double, lon: Double) async -> NetworkResponse {
        var components = URLComponents(string: weatherUrl)
        components?.queryItems = [
            URLQueryItem(name: latQueryItemName, value: String(lat)),
            URLQueryItem(name: lonQueryItemName, value: String(lon)),
            URLQueryItem(name: apiKeyQueryItemName, value: apiKey)
        ]
        
        guard let url = components?.url else{
            return ErrorResponse(errorMessage: "Could not convert \(weatherUrl) into url")
        }
        
        let request = URLRequest(url: url)
        
        let response = await NetworkManager.getResponse(dataType: WeatherInfo.self, request: request)
        return response
    }
    
}

