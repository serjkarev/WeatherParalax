//
//  CitiesPresenter.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit
import Alamofire

protocol CitiesViewPresenterProtocol {
    init(view: CitiesViewProtocol)
    var citiesCount: Int { get }
    func getCityFor(_ index: Int) -> City?
}

class CitiesPresenter {
    private weak var view: CitiesViewProtocol?
    private var cities: [City]?

    required init(view: CitiesViewProtocol) {
        self.view = view
        getCities()
    }
}

// MARK: - Private methods
private extension CitiesPresenter {
    func getCities() {
        guard let path = Bundle.main.path(forResource: "city_list", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            cities = try JSONDecoder().decode([City].self, from: jsonData)
        } catch {
            debugPrint("Error: \(error)")
        }
    }
}

// MARK: - CitiesViewPresenterProtocol methods
extension CitiesPresenter: CitiesViewPresenterProtocol {
    var citiesCount: Int {
        return cities?.count ?? 0
    }

    func getCityFor(_ index: Int) -> City? {
        guard let city = cities?[index] else { return nil }
        return city
    }
}
