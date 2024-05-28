//
//  TravelModel.swift
//
//  Created by Den on 2024/05/11.
//

import UIKit

struct Travel {
    let title: String
    let description: String?
    let travel_image: String?
    let grade: Double?
    let save: Int?
    var like: Bool?
    let ad: Bool
    
    var reviewText: String {
        guard let grade, let save else { return "" }
        return "(\(grade)) • 저장 \(save.formatted())"
    }
    
    var likeImage: String {
        guard let like else { return "heart" }
        return like ? "heart.fill" : "heart"
    }
    
    
}

struct TravelInfo {
    let travel: [Travel] = [
        Travel(title: "하나우마 베이",
               description: "아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소아름다운 자연을 감상할 수 있는 스노쿨링 명소",
               travel_image: "https://images.unsplash.com/photo-1539498508910-091b5e859b1d?q=80&w=3250&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 4.8,
               save: 6932,
               like: false,
               ad: false),
        Travel(title: "쿠알로아 랜치",
               description: "광활한 대자연에서 즐기는 다양하고 재미있는 액티비티",
               travel_image: "https://images.unsplash.com/photo-1709380733305-e65f500ab1ac?q=80&w=3264&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 4.9,
               save: 5167,
               like: true,
               ad: false),
        Travel(title: "알라 모아나 센터",
               description: "하와이 최고의 쇼핑 명소",
               travel_image: "https://images.unsplash.com/photo-1600215754990-6e7946d1e37a?q=80&w=2592&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 3.8,
               save: 8262,
               like: true,
               ad: false),
        Travel(title: "와이키키 비치",
               description: "세계적으로 유명한 하와이 최고의 해변",
               travel_image: "https://images.unsplash.com/photo-1507876466758-bc54f384809c?q=80&w=3309&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 4.2,
               save: 7892,
               like: true,
               ad: false),
        Travel(title: "이 기능 다음 주 까지 구현 되나요?\n다른 서비스처럼 이렇게 만들어주실래요?\n간단해 보이는데, 좀 더 빠르게 해줄 수 있나요?\n바로 새싹에서 당신을 가능하게 만듭니다!!🌱",
               description: nil,
               travel_image: nil,
               grade: nil,
               save: nil,
               like: nil,
               ad: true),
        Travel(title: "철도 박물관",
               description: "일본 철도의 역사를 둘러볼 수 있는 박물관",
               travel_image: "https://images.unsplash.com/photo-1562326303-31bb8d0f4873?q=80&w=3264&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 2.8,
               save: 3,
               like: false,
               ad: false),
        Travel(title: "도쿄 디즈니랜드",
               description: "월트 디즈니가 창조한 동화 속 세상",
               travel_image: "https://images.unsplash.com/photo-1545580492-8859ba8323f0?q=80&w=3174&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 4.7,
               save: 26076,
               like: true,
               ad: false),
        Travel(title: "도쿄 타워",
               description: "아름다운 전망을 즐길 수 있는 도쿄의 상징",
               travel_image: "https://images.unsplash.com/photo-1513407030348-c983a97b98d8?q=80&w=3272&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 4.1,
               save: 37077,
               like: false,
               ad: false),
        Travel(title: "도쿄 여행 예약은?\nXcode로 직접 예약앱을 만들면 되겠네요!",
               description: nil,
               travel_image: nil,
               grade: nil,
               save: nil,
               like: nil,
               ad: true),
        Travel(title: "동문 재래 시장",
               description: "먹거리와 생활용품을 판매하는, 제주에서 가장 큰 시장",
               travel_image: "https://images.unsplash.com/photo-1501523460185-2aa5d2a0f981?q=80&w=3331&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 4.0,
               save: 67696,
               like: true,
               ad: false),
        Travel(title: "제주 국제공항",
               description: "면세점이 있어 더욱 사랑받는, 제주 여행의 시작과 끝을 함께하는 공항",
               travel_image: "https://images.unsplash.com/photo-1556388158-158ea5ccacbd?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 4.8,
               save: 18817,
               like: true,
               ad: false),
        Travel(title: "서귀포 매일 올레 시장",
               description: "다양한 농수산물, 잡화, 먹거리를 판매하는 재래 시장",
               travel_image: "https://images.unsplash.com/photo-1511018761631-2e3eb1e4c972?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 3.9,
               save: 45399,
               like: false,
               ad: false),
        Travel(title: "성산일출봉",
               description: "유네스코 세계 자연 유산에 등재된, 제주 최고의 일출 명소",
               travel_image: "https://images.unsplash.com/photo-1622209018972-097984086b0b?q=80&w=3279&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 4.9,
               save: 44507,
               like: true,
               ad: false),
        Travel(title: "제주 비행기 최저가! 예약 문의는 취업부터!",
               description: nil,
               travel_image: nil,
               grade: nil,
               save: nil,
               like: nil,
               ad: true),
        Travel(title: "영등포 캠퍼스",
               description: "Jack님과 함께하는,\n우당탕탕 iOS 개발 성장기!",
               travel_image: "https://images.unsplash.com/photo-1679285516851-4f0cb04a3893?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
               grade: 5.0,
               save: 30,
               like: true,
               ad: false),
    ]
}
