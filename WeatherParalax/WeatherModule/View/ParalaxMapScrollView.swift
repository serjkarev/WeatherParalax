//
//  ParalaxMapScrollView.swift
//  WeatherParalax
//
//  Created by skarev on 01.09.2022.
//

import UIKit

final class ParalaxMapScrollView: UIScrollView {

//    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var mapContentView: UIView!
    @IBOutlet private weak var height: NSLayoutConstraint!
//    @IBOutlet private weak var bottom: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let offsetY = -self.contentOffset.y
//        bottom.constant = offsetY >= 0 ? 0 :offsetY / 2
        height.constant = max(mapContentView.bounds.height, mapContentView.bounds.height + offsetY)
//        mapView.clipsToBounds = offsetY <= 0
    }

}
