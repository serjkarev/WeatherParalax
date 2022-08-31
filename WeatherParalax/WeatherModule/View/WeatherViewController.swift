//
//  WeatherViewController.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

protocol WeatherViewProtocol: AnyObject {
    func succes()
    func failure(title: String, description: String)
}

class WeatherViewController: UIViewController {

    var presenter: WeatherViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
