//
//  CitiesViewController.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol CitiesViewProtocol: AnyObject {
    func failure(title: String, description: String)
}

final class CitiesViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    private let searchController = UISearchController()

    var presenter: CitiesViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }
}

// MARK: - Priavte methods
private extension CitiesViewController {
    func setupNavBar() {
        self.title = "Cities"
        
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UISearchBar delegate methods
extension CitiesViewController: UISearchBarDelegate {}

extension CitiesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.filterForSearchBar(searchController.searchBar.text)
        tableView.reloadData()
    }
}

// MARK: - UITableView delegate methods
extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = searchController.isActive ? presenter?.getFilteredCityFor(indexPath.row) : presenter?.getCityFor(indexPath.row)
        let weatherViewController = ModuleBuilder.createWeatherModule(with: city)
        navigationController?.pushViewController(weatherViewController, animated: true)
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchController.isActive ? presenter?.filteredCitiesCount ?? 0 : presenter?.citiesCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        let city = searchController.isActive ? presenter?.getFilteredCityFor(indexPath.row) : presenter?.getCityFor(indexPath.row)
        cell.cityName = city?.name
        cell.rowNumber = indexPath.row
        return cell
    }
}

// MARK: - CitiesViewProtocol methods
extension CitiesViewController: CitiesViewProtocol {
    func failure(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
