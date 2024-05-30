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
    
    @IBOutlet var shadowView: UIView!
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
 
        //shadowView 설정
        shadowView.layer.cornerRadius = 24
        shadowView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        shadowView.layer.shadowOffset = CGSize(width: 4, height: 4)
        shadowView.layer.shadowRadius = 4
        shadowView.layer.shadowOpacity = 0.5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureBackgroundView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setData(data: City, searchText: String?){
        
        if let url = URL(string: data.city_image) {
            cityImageView.kf.setImage(with: url)
        }
        
        titleLabel.attributedText = data.title.highlightSearchText(searchText: searchText)
        citiesListLabel.attributedText = data.city_explain.highlightSearchText(searchText: searchText)
    }
    
}

extension String {
    func highlightSearchText(searchText: String?) -> NSAttributedString {
        guard let searchKey = searchText?.lowercased(), !searchKey.isEmpty else {
            return NSAttributedString(string: self)
        }
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.backgroundColor, value: UIColor(hexCode: "5FC3A6"), range: (self as NSString).range(of: searchKey, options: .caseInsensitive))
        
        return attributedString
    }
}
