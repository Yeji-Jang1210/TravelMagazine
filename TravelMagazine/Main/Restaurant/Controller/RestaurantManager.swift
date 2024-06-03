//
//  RestaurantManager.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/26/24.
//

import Foundation

class RestaurantManager {
    var list = RestaurantList().restaurantArray
    var filteredList: [Restaurant] = []
    var likeList: [String:Bool] = [:]
    
    var category: FoodCategory = .all {
        didSet {
            filteringRestaurantList()
        }
    }
    
    var orderPrice: OrderPrice? = nil {
        didSet {
            OrderByPrice()
        }
    }
    
    var isLikeListButtonTapped: Bool = false {
        didSet {
            filteringRestaurantList()
            likeButtonTitle = isLikeListButtonTapped ? Localized.restaurant_likedButton.text : Localized.restaurant_allCaseButton.text
        }
    }
    var likeButtonTitle: String = ""
    
    init(){
        filteredList = list
        for name in list.map({ $0.name }) {
            likeList[name] = false
        }
    }
    
    private func filteringRestaurantList(){
        filteredList = list
        
        if category != .all {
            filteredList = list.filter { $0.category == category.rawValue }
        }
        
        if isLikeListButtonTapped {
            let likeList = likeList
                .filter({$0.value == true})
                .map({$0.key})
            
            filteredList = filteredList.filter({ likeList.contains($0.name)})
        }
    }
    
    private func OrderByPrice(){
        switch orderPrice {
        case .low:
            filteredList.sort(by: { $0.price < $1.price })
        case .high:
            filteredList.sort(by: { $0.price > $1.price })
        case nil:
            return
        }
    }
    
    public func searchRestaurantName(_ text: String){
        filteredList = filteredList.filter{ $0.name.contains(text) }
    }
}

enum FoodCategory: String, CaseIterable {
    case all = "전체"
    case cafe = "카페"
    case korean = "한식"
    case chinese = "중식"
    case japanese = "일식"
    case western = "양식"
}

enum OrderPrice: String, CaseIterable {
    case low = "저가순"
    case high = "고가순"
}
