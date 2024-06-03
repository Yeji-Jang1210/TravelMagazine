//
//  TravelTableViewCell.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/27/24.
//

import UIKit
import Cosmos
import Kingfisher

class TravelTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starRateView: CosmosView!
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var travelImageView: UIImageView!
    
    static let identifier: String = "TravelTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
        
        travelImageView.backgroundColor = .lightGray
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 15
        starRateView.settings.updateOnTouch = false
    }
    
    func configureLabel(){
        nameLabel.font = FontManager.title.font
        nameLabel.textColor = FontManager.title.color
        
        descriptionLabel.font = FontManager.subTitle.font
        descriptionLabel.textColor = FontManager.subTitle.color
        
        reviewLabel.font = FontManager.discription.font
        reviewLabel.textColor = FontManager.discription.color
    }
    
    func setLayout(data: Travel){
        nameLabel.text = data.title
        descriptionLabel.text = data.description
        
        
        starRateView.rating = data.grade ?? 0
        reviewLabel.text = data.reviewText
        
        if let urlStr = data.travel_image, let url = URL(string: urlStr) {
            travelImageView.kf.setImage(with: url)
        }
        
        likeButton.setImage(data.likeImage, for: .normal)
        
    }
    
}
