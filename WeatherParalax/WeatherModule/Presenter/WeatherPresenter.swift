//
//  WeatherPresenter.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol WeatherViewPresenterProtocol {
    init(view: WeatherViewProtocol, with weather: Weather)
}

class WeatherPresenter {
    private weak var view: WeatherViewProtocol?
    private var weather: Weather

    required init(view: WeatherViewProtocol, with weather: Weather) {
        self.view = view
        self.weather = weather
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

}
