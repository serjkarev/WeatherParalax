//
//  WeatherViewController.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit
import MapKit

protocol WeatherViewProtocol: AnyObject {
    func succes()
    func failure(title: String, description: String)
}

final class WeatherViewController: UIViewController {

    // MARK: - IBOutlet
//    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var airHumidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!

    var presenter: WeatherViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
//        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    }
}

// MARK: - Priavte methods
private extension WeatherViewController {
    func setupNavBar() {
        self.title = presenter?.cityName
    }
}

// MARK: - WeatherViewProtocol methods
extension WeatherViewController: WeatherViewProtocol {
    func succes() {
        
    }

    func failure(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
