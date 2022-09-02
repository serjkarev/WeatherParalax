//
//  MapService.swift
//  WeatherParalax
//
//  Created by skarev on 03.09.2022.
//

import Foundation
import MapKit

protocol MapServiceProtocol {
    func getSnapshotFor(lat: Double, lon: Double, completion: @escaping (Result<UIImage?, Error>) -> Void)
}

fileprivate final class LocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

final class MapService: MapServiceProtocol {
    func getSnapshotFor(lat: Double, lon: Double, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let options = MKMapSnapshotter.Options()
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let annotation = LocationAnnotation(coordinate: center)
        options.region = MKCoordinateRegion(center: center, span: MKCoordinateSpan())
        options.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
        options.scale = UIScreen.main.scale
        options.mapType = .standard
        
        let snapshot = MKMapSnapshotter(options: options)
        snapshot.start(with: .global()) { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
                    snapshot.image.draw(at: .zero)
                    
                    let point = snapshot.point(for: center)
                    
                    let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ReuseID")
                    annotationView.contentMode = .scaleAspectFit
                    annotationView.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
                    annotationView.drawHierarchy(in: CGRect(x: point.x, y: point.y, width: annotationView.bounds.size.width, height: annotationView.bounds.size.height), afterScreenUpdates: true)
                    
                    let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
                    completion(.success(drawnImage))
                }
            }
        }
    }
}
