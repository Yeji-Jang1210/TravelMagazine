//
//  String+Extension.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/1/24.
//

import Foundation

extension String {
    func convertStringToDate(_ dateStyle: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = dateStyle
        
        return dateFormat.date(from: self)
    }
}
