//
//  AdTableViewCell.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    static let identifier:String = "AdTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 12
        
        //cornerRadius를 주기 위해 clipsToBounds를 설정해준다.
        adLabel.clipsToBounds = true
        adLabel.backgroundColor = .white
        adLabel.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = AdColor.allCases.randomElement()?.color
    }
    
    func setLayout(title: String){
        self.titleLabel.text = title
    }
    
}
