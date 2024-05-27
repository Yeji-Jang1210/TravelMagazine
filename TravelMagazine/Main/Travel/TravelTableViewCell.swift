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
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 15
        starRateView.settings.updateOnTouch = false
    }
    
    func setLayout(data: Travel){
        nameLabel.text = data.title
        descriptionLabel.text = data.description
        
        if let grade = data.grade, let save = data.save {
            starRateView.rating = grade
            reviewLabel.text = "(\(grade)) • 저장 \(save.formatted())"
        } else {
            reviewLabel.text = ""
        }
        
        
        if let urlStr = data.travel_image, let url = URL(string: urlStr) {
            travelImageView.kf.setImage(with: url)
        }
        
        if let liked = data.like {
            let image = liked ? "heart.fill" : "heart"
            likeButton.setBackgroundImage(UIImage(systemName: image), for: .normal)
            likeButton.layoutIfNeeded()
            likeButton.subviews.first?.contentMode = .scaleAspectFit
        }
        
    }
    
}
