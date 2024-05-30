//
//  TravelMagazineFont.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/30/24.
//

import UIKit

struct TextStyle {
    let font: UIFont
    let color: UIColor
}

class FontManager {
    static var title: TextStyle { return TextStyle(font: .systemFont(ofSize: 16, weight: .bold), color: .black) }
    static var subTitle: TextStyle { return TextStyle(font: .systemFont(ofSize: 14), color: .lightGray) }
    static var discription: TextStyle { return TextStyle(font: .systemFont(ofSize: 12), color: .lightGray)}
}
