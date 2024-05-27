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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLayout(title: String, hexCode: AdColor){
        backgroundColor = hexCode.color
        self.titleLabel.text = title
    }
    
}

enum AdColor: String, CaseIterable {
    case F6BD60
    case F7EDE2
    
    var color: UIColor {
        return UIColor(hexCode: self.rawValue)
    }
}
