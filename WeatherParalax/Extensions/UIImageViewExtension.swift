//
//  UIImageViewExtension.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageURL: String) {
        self.kf.setImage(with: URL(string: imageURL))
    }
}
