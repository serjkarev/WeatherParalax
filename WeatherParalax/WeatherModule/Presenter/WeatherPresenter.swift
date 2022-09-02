//
//  WeatherPresenter.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit
import MapKit

protocol WeatherViewPresenterProtocol {
    init(view: WeatherViewProtocol, with city: City?)
    var cityName: String? { get }
    var cityImage: UIImage? { get }
}

final class WeatherPresenter {
    private weak var view: WeatherViewProtocol?
    private var city: City?
    private var weather: Weather?
    private var mapSnapShot: UIImage?

    required init(view: WeatherViewProtocol, with city: City?) {
        self.view = view
        self.city = city
        getWeather()
        getMapSnapshot()
    }
}

// MARK: - Private methods
private extension WeatherPresenter {
    func getWeather() {
        
    }
    
    func getMapSnapshot() {
        guard let lat = city?.coord.lat, let lon = city?.coord.lon else { return }
        let options = MKMapSnapshotter.Options()
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let annotation = LocationAnnotation(coordinate: center)
        options.region = MKCoordinateRegion(center: center, span: MKCoordinateSpan())
        options.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)//
        options.scale = UIScreen.main.scale
        options.mapType = .standard
        
        let snapshot = MKMapSnapshotter(options: options)
        snapshot.start(with: .global()) { [weak self] (snapshot, error) in
            guard let self = self else { return }
            guard error == nil, let snapshot = snapshot else { return }
            
            DispatchQueue.main.async {
                UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
                snapshot.image.draw(at: .zero)
                
                let point = snapshot.point(for: center)
                
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ReuseID")
                annotationView.contentMode = .scaleAspectFit
                annotationView.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
                annotationView.drawHierarchy(in: CGRect(x: point.x, y: point.y, width: annotationView.bounds.size.width, height: annotationView.bounds.size.height), afterScreenUpdates: true)
                
                let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
                self.mapSnapShot = drawnImage
                self.view?.succesMapDownload()
            }
        }
    }
}

// MARK: - WeatherViewPresenterProtocol methods
extension WeatherPresenter: WeatherViewPresenterProtocol {
    var cityName: String? {
        city?.name
    }
    
    var cityImage: UIImage? {
        mapSnapShot
    }
}

final class LocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
