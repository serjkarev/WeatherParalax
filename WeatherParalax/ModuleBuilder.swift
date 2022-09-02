//
//  ModuleBuilder.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol Builder {
    static func createCitiesModule() -> UIViewController
    static func createWeatherModule(with city: City?) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createCitiesModule() -> UIViewController {
        let viewController = CitiesViewController()
        let presenter = CitiesPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }

    static func createWeatherModule(with city: City?) -> UIViewController {
        let viewController = WeatherViewController()
        let networkService = NetworkSevice()
        let presenter = WeatherPresenter(view: viewController,networkService: networkService, with: city)
        viewController.presenter = presenter
        return viewController
    }
}
