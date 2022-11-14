//
//  WeatherConditionTableViewCell.swift
//  CaseStudy-BilalYalcin
//
//  Created by Bilal Yalcin on 14.11.2022.
//

import UIKit
import Kingfisher

class WeatherConditionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellFirstRightItem: UILabel!
    @IBOutlet weak var cellSecondRightItem: UILabel!
    @IBOutlet weak var cellType: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.image = nil
    }
    
    func configureCell(forecast: Forecast) {
        cellFirstRightItem.text = forecast.highTemp + DEGREE_ICON
        cellSecondRightItem.text = forecast.lowTemp + DEGREE_ICON
        cellType.text = forecast.weatherType
        let url = URL(string: "https://openweathermap.org/img/wn/\(forecast.weatherIcon)@2x.png")
        cellImage.kf.setImage(with: url)
        cellTitle.text = forecast.date
    }
}
