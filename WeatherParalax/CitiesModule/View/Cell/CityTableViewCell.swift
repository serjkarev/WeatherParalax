//
//  CityTableViewCell.swift
//  WeatherParalax
//
//  Created by skarev on 31.08.2022.
//

import UIKit

enum ImageVariant: String {
    case even = "https://infotech.gov.ua/storage/img/Temp3.png"
    case odd = "https://infotech.gov.ua/storage/img/Temp1.png"
}

final class CityTableViewCell: UITableViewCell {

    @IBOutlet private weak var cityImageView: UIImageView!
    @IBOutlet private weak var cityTitleLabel: UILabel!
    
    var cityName: String? {
        didSet {
            self.cityTitleLabel.text = self.cityName
        }
    }
    
    var rowNumber: Int? {
        didSet {
            guard let rowNumber = rowNumber else { return }
            let variant: ImageVariant = rowNumber % 2 == 0 ? .even : .odd
            self.cityImageView.setImage(imageURL: variant.rawValue)
        }
    }
}
