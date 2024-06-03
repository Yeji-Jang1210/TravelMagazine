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

class ChatManager {
    static var nicknameFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    static var chatBubbleCornerRadius:CGFloat = 12
    static var chatBubbleBorderWidth:CGFloat = 1
    static var chatBubbleBorderColor = UIColor.darkGray.cgColor
    
    static var userChatBubbleColor = UIColor.systemGray6
    static var otherChatBubbleColor =  UIColor.systemBackground
    
    static var chatFont = UIFont.systemFont(ofSize: 14)
    static var timeFont = UIFont.systemFont(ofSize: 12)
    static var timeFontColor = UIColor.darkGray
    
    static var chatDataDateFormat = "yyyy-MM-dd HH:mm"
    static var chatBubbleTimeFormat = "HH:mm a"
    static var chatRoomDataFormat = "yy.MM.dd"
}
