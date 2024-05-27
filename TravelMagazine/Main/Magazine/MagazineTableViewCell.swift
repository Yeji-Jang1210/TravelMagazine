//
//  MagazineTableViewCell.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/25/24.
//

import UIKit
import Kingfisher

class MagazineTableViewCell: UITableViewCell {
    
    static let identifier: String = "MagazineTableViewCell"

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.layer.cornerRadius = 15
        photoImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.numberOfLines = 0
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .right
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setUI(image: String, title: String, subtitle: String, date: String){
        
        let url = URL(string: image)
        photoImageView.kf.indicatorType = .activity
        photoImageView.kf.setImage(with: url)
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        dateLabel.text = date
    }

}
