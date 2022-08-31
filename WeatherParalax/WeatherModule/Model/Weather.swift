//
//  Weather.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let weather: [WeatherElement]
    let main: Main
    let wind: Wind
    let name: String
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let description: String
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}
