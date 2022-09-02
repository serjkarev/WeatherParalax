//
//  CitiesPresenter.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol CitiesViewPresenterProtocol {
    init(view: CitiesViewProtocol)
    var citiesCount: Int { get }
    var filteredCitiesCount: Int { get }
    func getCityFor(_ index: Int) -> City?
    func getFilteredCityFor(_ index: Int) -> City?
    func filterForSearchBar(_ searchText: String?)
}

final class CitiesPresenter {
    private weak var view: CitiesViewProtocol?
    private var cities: [City]?
    private var filteredCities = [City]()

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
            self.view?.failure(title: "Reading issue", description: error.localizedDescription)
            debugPrint("Error: \(error.localizedDescription)")
        }
    }
}

// MARK: - CitiesViewPresenterProtocol methods
extension CitiesPresenter: CitiesViewPresenterProtocol {
    var citiesCount: Int {
        return cities?.count ?? 0
    }

    var filteredCitiesCount: Int {
        return filteredCities.count
    }
    
    func getCityFor(_ index: Int) -> City? {
        guard let city = cities?[index] else { return nil }
        return city
    }
    
    func getFilteredCityFor(_ index: Int) -> City? {
        return filteredCities[index]
    }
    
    func filterForSearchBar(_ searchText: String?) {
        guard let searchText = searchText else { return }
        guard let cities = cities else { return }
        filteredCities = cities.filter { city in
            if searchText != "" {
                return city.name.lowercased().contains(searchText.lowercased())
            }
            return true
        }
    }
}
