//
//  String+Extension.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/1/24.
//

import Foundation

extension String {
    func convertStringToDate(_ dateFormatStyle: String) -> Date? {
        let dateFormat = DateFormatter()
        
        //20240601 local정보 UserDefaultsManager만들어서 관리하기
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = dateFormatStyle
        
        return dateFormat.date(from: self)
    }
}
