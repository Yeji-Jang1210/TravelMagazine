//
//  PopularCityTableViewCell.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/29/24.
//

import UIKit
import Kingfisher

class PopularCityTableViewCell: UITableViewCell {
    
    static let identifier: String = "PopularCityTableViewCell"

    @IBOutlet var overlayView: UIView!
    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var citiesListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBackgroundView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cityImageView.contentMode = .scaleAspectFill
    }
    
    private func configureBackgroundView(){
        //특정 모서리 둥글게
        cellBackgroundView.clipsToBounds = true
        cellBackgroundView.layer.cornerRadius = 24
        cellBackgroundView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellBackgroundView.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setData(data: City){
        if let url = URL(string: data.city_image) {
            cityImageView.kf.setImage(with: url)
        }
        
        titleLabel.text = data.title
        citiesListLabel.text = data.city_explain
    }
    
}
