//
//  RestaurantManager.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/26/24.
//

import Foundation

class RestaurantManager {
    var list = RestaurantList().restaurantArray
    var likeList: [String:Bool] = [:]
    
    var category: FoodCategory = .all {
        didSet {
            filteringRestaurantList()
        }
    }
    
    var orderPrice: OrderPrice? = nil {
        didSet {
            filteringRestaurantList()
        }
    }
    
    var isLikeListButtonTapped: Bool = false
    
    init(){
        for name in list.map({ $0.name }) {
            likeList[name] = false
        }
    }
    
    func filteringRestaurantList(){
        filteringCategory()
        OrderByPrice()
        getLikedRestaurant()
    }
    
    func getLikedRestaurant(){
        if isLikeListButtonTapped {
            let likeList = likeList
                .filter({$0.value == true})
                .map({$0.key})
            
            list = list.filter({ likeList.contains($0.name)})
        } else {
            list = RestaurantList().restaurantArray
            filteringCategory()
            OrderByPrice()
        }
    }
    
    private func OrderByPrice(){
        switch orderPrice {
        case .low:
            list.sort(by: { $0.price < $1.price })
        case .high:
            list.sort(by: { $0.price > $1.price })
        case nil:
            return
        }
    }
    
    private func filteringCategory(){
        list = RestaurantList().restaurantArray
        if category != .all {
            list = list.filter { $0.category == category.rawValue }
        }
    }
    
    public func searchRestaurantName(_ text: String){
        list = list.filter{ $0.name.contains(text) }
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
