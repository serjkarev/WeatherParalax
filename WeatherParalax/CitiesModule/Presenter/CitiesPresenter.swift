//
//  CitiesPresenter.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol CitiesViewPresenterProtocol {
    init(view: CitiesViewProtocol, fileService: FileServiceProtocol)
    var citiesCount: Int { get }
    var filteredCitiesCount: Int { get }
    func getCityFor(_ index: Int) -> City?
    func getFilteredCityFor(_ index: Int) -> City?
    func filterForSearchBar(_ searchText: String?)
}

final class CitiesPresenter {
    private weak var view: CitiesViewProtocol?
    private let fileService: FileServiceProtocol
    private var cities: [City]?
    private var filteredCities = [City]()

    required init(view: CitiesViewProtocol, fileService: FileServiceProtocol) {
        self.view = view
        self.fileService = fileService
        getCities()
    }
}

// MARK: - Private methods
private extension CitiesPresenter {
    func getCities() {
        fileService.getCitiesFrom(file: "city_list") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cities):
                self.cities = cities
            case .failure(let error):
                self.view?.failure(title: "Reading issue", description: error.localizedDescription)
            }
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
