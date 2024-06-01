//
//  Magazine.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/25/24.
//

import Foundation

struct Magazine {
    let title: String
    let subtitle: String
    let photo_image: String
    let date: String
    let link: String
    
    //use DateFormatter
    var dateFormat: String {
        guard let date = date.convertStringToDate("yyMMdd") else { return "" }
        return date.convertDateToString("yy년 MM월 dd일") ?? ""
    }
}
