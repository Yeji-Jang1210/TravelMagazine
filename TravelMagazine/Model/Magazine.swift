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
    
    var dateFormat: String {
        guard let date = convertStringToDate(date) else {
            return ""
        }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yy년 MM월 dd일"
        return dateFormat.string(from: date)
    }
    
    private func convertStringToDate(_ text: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyMMdd"
        
        return dateFormat.date(from: text)
    }
}
