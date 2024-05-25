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
        // Initialization code
        photoImageView.layer.cornerRadius = 4
    }
    
    public func setUI(image: String, title: String, type: String, address: String, phoneNumber: String, price: Int){
        
        let url = URL(string: image)
        photoImageView.kf.setImage(with: url)
        
        titleLabel.text = title
        foodTypeLabel.text = type
        addressLabel.text = address
        phoneNumberButton.titleLabel?.text = phoneNumber
        priceLabel.text = price.formatted()
        
        
    }

}
