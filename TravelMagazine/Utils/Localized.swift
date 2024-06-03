//
//  Localized.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/3/24.
//

import UIKit

enum Localized {
    case travel_navigationTitle
    case restaurant_navigationTitle
    case city_navigation_title
    case city_ad_navigation_title
    case travelTalk_navigationTitle
    
    case restaurant_categoryButton
    case restaurant_priceButton
    case restaurant_likedButton
    case restaurant_allCaseButton
    case restaurant_call_dlg
    
    case city_loadData_error_dlg
    case city_swipe_left
    case city_swipe_right
    
    case travelTalk_searchTextField_placeholder
    case travelTalk_messageTextView_placeholder
    case travelTalk_sendMessage_error
    
    var text: String {
        switch self {
        case .restaurant_categoryButton:
            return "음식 종류"
        case .restaurant_likedButton:
            return "즐겨찾기"
        case .restaurant_allCaseButton:
            return "전체보기"
        case .restaurant_priceButton:
            return "가격"
        case .travelTalk_searchTextField_placeholder:
            return "친구 이름을 검색해보세요"
        case .travelTalk_messageTextView_placeholder:
            return "메세지를 입력하세요"
        default:
            return ""
        }
    }
    
    var title: String {
        switch self {
        case .travel_navigationTitle:
            return "SeSAC TRAVEL"
        case .restaurant_navigationTitle:
            return "오늘 뭐먹지?!"
        case .travelTalk_navigationTitle:
            return "TRAVEL TALK"
        case .city_navigation_title:
            return "관광지 확인"
        case .city_ad_navigation_title:
            return "광고화면"
        case .travelTalk_sendMessage_error, .city_loadData_error_dlg:
            return "오류"
        case .restaurant_call_dlg:
            return "통화"
        case .city_swipe_left:
            return "공유"
        case .city_swipe_right:
            return "삭제"
        default:
            return ""
        }
    }
    
    var subtitle: String {
        switch self {
        case .travelTalk_sendMessage_error:
            return "메세지 전송에 실패했습니다."
        case .city_loadData_error_dlg:
            return "데이터를 불러오는데 실패했습니다"
        default:
            return ""
        }
    }
    
    var confirmText: String {
        switch self {
        case .travelTalk_sendMessage_error, .city_loadData_error_dlg:
            return "확인"
        case .restaurant_call_dlg:
            return "취소"
        default:
            return ""
        }
    }
}

enum IconManager: String {
    case ellipsis = "ellipsis"
    case search = "magnifyingglass"
    case emptyProfile = "emptyProfile"
    case backButton = "chevron.backward"
    case sendButton = "paperplane"
    case heart = "heart"
    case heartFill = "heart.fill"
    case map = "map"
    case trash = "trash"
    case arrowUturnLeft = "arrow.uturn.left"
    case xMark = "xmark"
    
    var icon: UIImage? {
        switch self {
        case .emptyProfile:
            return UIImage(named: self.rawValue)
        default:
            return UIImage(systemName: self.rawValue)
        }
    }
}
