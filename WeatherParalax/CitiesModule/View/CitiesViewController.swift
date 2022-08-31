//
//  CitiesViewController.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol CitiesViewProtocol: AnyObject {
    func succes()
    func failure(title: String, description: String)
}

class CitiesViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

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
    }

    func setupTableView() {
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableView delegate methods
extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.citiesCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        let city = presenter?.getCityFor(indexPath.row)
        cell.cityName = city?.name
        cell.rowNumber = indexPath.row
        return cell
    }
}

// MARK: - CitiesViewProtocol methods
extension CitiesViewController: CitiesViewProtocol {
    func succes() {
        tableView.reloadData()
    }

    func failure(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
