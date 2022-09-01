//
//  WeatherPresenter.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol WeatherViewPresenterProtocol {
    init(view: WeatherViewProtocol, with city: City?)
    var cityName: String? { get }
}

final class WeatherPresenter {
    private weak var view: WeatherViewProtocol?
    private var city: City?

    required init(view: WeatherViewProtocol, with city: City?) {
        self.view = view
        self.city = city
        getWeather()
    }
}

// MARK: - Private methods
private extension WeatherPresenter {
    func getWeather() {
        
    }
}

// MARK: - WeatherViewPresenterProtocol methods
extension WeatherPresenter: WeatherViewPresenterProtocol {
    var cityName: String? {
        city?.name
    }
}
