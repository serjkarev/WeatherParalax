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
        let fileService = FileService()
        let presenter = CitiesPresenter(view: viewController, fileService: fileService)
        viewController.presenter = presenter
        return viewController
    }

    static func createWeatherModule(with city: City?) -> UIViewController {
        let viewController = WeatherViewController()
        let networkService = NetworkSevice()
        let mapService = MapService()
        let presenter = WeatherPresenter(view: viewController, networkService: networkService, mapService: mapService, with: city)
        viewController.presenter = presenter
        return viewController
    }
}
