//
//  City.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import Foundation

// MARK: - CityElement
struct CityElement: Codable {
    let id: Int
    let name, state, country: String
    let coord: Coord
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}
