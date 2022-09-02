//
//  WeatherPresenter.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol WeatherViewPresenterProtocol {
    init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol, mapService: MapServiceProtocol, with city: City?)
    var cityName: String? { get }
    var cityImage: UIImage? { get }
    var currnetTemperature: String? { get }
    var weatherDescription: String? { get }
    var minTemperature: String? { get }
    var maxTemperature: String? { get }
    var airHumidity: String? { get }
    var windSpeed: String? { get }
}

final class WeatherPresenter {
    private weak var view: WeatherViewProtocol?
    private let networkSevice: NetworkServiceProtocol
    private let mapService: MapServiceProtocol
    private var city: City?
    private var weather: Weather?
    private var mapSnapShot: UIImage?

    required init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol, mapService: MapServiceProtocol, with city: City?) {
        self.view = view
        self.networkSevice = networkService
        self.mapService = mapService
        self.city = city
        getWeather()
        getMapSnapshot()
    }
}

// MARK: - Private methods
private extension WeatherPresenter {
    func getWeather() {
        guard let lat = city?.coord.lat, let lon = city?.coord.lon else { return }
        networkSevice.getWeatherFor(latitude: lat, longitude: lon) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weather = weather
                    self.view?.succesWeatherDownload()
                case .failure(let error):
                    self.view?.failure(title: "Can't load weather", description: error.localizedDescription)
                }
            }
        }
    }
    
    func getMapSnapshot() {
        guard let lat = city?.coord.lat, let lon = city?.coord.lon else { return }
        mapService.getSnapshotFor(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let snapshot):
                self.mapSnapShot = snapshot
                self.view?.succesMapDownload()
            case .failure(let error):
                self.view?.failure(title: "Can't load map snapshot", description: error.localizedDescription)
            }
        }
    }
}

// MARK: - WeatherViewPresenterProtocol methods
extension WeatherPresenter: WeatherViewPresenterProtocol {
    var cityName: String? {
        city?.name
    }
    
    var cityImage: UIImage? {
        mapSnapShot
    }
    
    var currnetTemperature: String? {
        guard let weather = weather else { return nil }
        return String(format: "%.0f", weather.main.temp) + "℃"
    }
    
    var weatherDescription: String? {
        guard let description = weather?.weather.first?.description else { return nil }
        return description.prefix(1).uppercased() + description.lowercased().dropFirst()
    }
    
    var minTemperature: String? {
        guard let weather = weather else { return nil }
        return String(format: "%.0f", weather.main.tempMin) + "℃"
    }
    
    var maxTemperature: String? {
        guard let weather = weather else { return nil }
        return String(format: "%.0f", weather.main.tempMax) + "℃"
    }
    
    var airHumidity: String? {
        guard let weather = weather else { return nil }
        return String(weather.main.humidity) + "%"
    }
    
    var windSpeed: String? {
        guard let weather = weather else { return nil }
        return String(format: "%.0f", weather.wind.speed) + "m/s"
    }
}
