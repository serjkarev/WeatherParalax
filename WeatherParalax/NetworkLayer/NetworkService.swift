//
//  NetworkService.swift
//  WeatherParalax
//
//  Created by skarev on 02.09.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getWeatherFor(latitude: Double, longitude: Double, completion: @escaping (Result<Weather?, Error>) -> Void)
}

final class NetworkSevice: NetworkServiceProtocol {
    private let appId: String = "6be715f794d3b44a90cd8a1995626f11"// move to info.plist
    
    func getWeatherFor(latitude: Double, longitude: Double, completion: @escaping (Result<Weather?, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: appId),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "units", value: "metric")
        ]
        guard let url = urlComponents.url else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(Weather.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
