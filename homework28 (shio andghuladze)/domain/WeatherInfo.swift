//
//  Weather.swift
//  homework28 (shio andghuladze)
//
//  Created by shio andghuladze on 30.08.22.
//

import Foundation

struct WeatherInfo: Decodable{
    let weather: [Weather]
    let wind: Wind
    let main: MainStats
}

struct Weather: Decodable {
    let description: String
}

struct Wind: Decodable{
    let speed: Double
}

struct MainStats: Decodable {
    let temp: Double
}
