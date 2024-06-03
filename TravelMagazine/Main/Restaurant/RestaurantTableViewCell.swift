//
//  RestaurantTableViewCell.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/26/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var foodTypeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var phoneNumberButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.cornerRadius = 4
    }
    
    public func setUI(data: Restaurant, liked: Bool? = false){
        
        let url = URL(string: data.image)
        photoImageView.kf.setImage(with: url)
        
        titleLabel.text = data.name
        foodTypeLabel.text = data.category
        addressLabel.text = data.address
        phoneNumberButton.titleLabel?.text = data.phoneNumber
        priceLabel.text = data.price.formatted()
        
        if let liked {
            let image = liked ? IconManager.heartFill.icon : IconManager.heart.icon
            likeButton.setBackgroundImage(image, for: .normal)
            likeButton.layoutIfNeeded()
            likeButton.subviews.first?.contentMode = .scaleAspectFit
        }
    }

}
