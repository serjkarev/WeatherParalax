//
//  ModuleBuilder.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol Builder {
    static func createCitiesModule() -> UIViewController
    static func createWeatherModule(with weather: Weather) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createCitiesModule() -> UIViewController {
        let viewController = CitiesViewController()
        let presenter = CitiesPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }

    static func createWeatherModule(with weather: Weather) -> UIViewController {
        let viewController = WeatherViewController()
        let presenter = WeatherPresenter(view: viewController, with: weather)
        viewController.presenter = presenter
        return viewController
    }
}
