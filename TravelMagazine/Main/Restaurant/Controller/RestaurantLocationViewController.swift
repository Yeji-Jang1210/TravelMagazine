//
//  RestaurantLocationViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/30/24.
//

import UIKit
import CoreLocation
import MapKit

enum RestaurantCategory: String, CaseIterable {
    case all = "전체"
    case korean = "한식"
    case snackBar = "분식"
    case chinese = "중식"
    case japanese = "일식"
    case western = "양식"
}

class RestaurantLocationViewController: UIViewController {
    
    static var identifier = String(describing: RestaurantLocationViewController.self)
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var currentLocationButton: UIButton!
    
    var list: [Restaurant] = RestaurantList().restaurantArray
    lazy var filteredList: [Restaurant] = list
    let center = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        fetchMapAnnotations()
        
        locationManager.delegate = self
        
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
    }
    
    func configureNavigationItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
    }
    
    func setRegion(center: CLLocationCoordinate2D){
        let center = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
    }
    
    func fetchMapAnnotations(){
        var annotations: [MKAnnotation] = []
        
        for item in filteredList {
            //식당 위치 넣기
            let annotation = CustomAnnotation(title: item.mapViewTitle, subTitle: item.address, latitude: item.latitude, longitude: item.longitude)
            annotations.append(annotation)
        }
        
        mapView.isZoomEnabled = true
        
        //사용자 위치 추가
        mapView.showsUserLocation = true
        mapView.addAnnotations(annotations)
        
    }
    
    @objc func filterButtonTapped(_ sender: UIButton){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        for category in RestaurantCategory.allCases {
            let alertAction = UIAlertAction(title: category.rawValue, style: .default) { _ in
                self.filteredRestaurants(category)
            }
            alert.addAction(alertAction)
        }
        
        present(alert, animated: true)
    }
    
    func filteredRestaurants(_ category: RestaurantCategory){
        mapView.removeAnnotations(mapView.annotations)
        
        filteredList = category == .all ? list : list.filter({ $0.category == category.rawValue })
        fetchMapAnnotations()
    }
}

class CustomAnnotation: NSObject, MKAnnotation{
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    var subTitle: String?
    
    init(title: String?, subTitle: String?, latitude: Double, longitude: Double){
        self.title = title
        self.subTitle = subTitle
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

//위치 관련 methods
extension RestaurantLocationViewController {
    
    //권한 체크
    func checkDeviceLocationAuthorization(){
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *){
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else {
                print("위치 서비스가 꺼져있음")
            }
        }
    }
    
    //현재 상태 확인 후 요청
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("위치 거부")
            showAlert()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print("error")
        }
    }
    
    @objc func currentLocationButtonTapped(){
        locationManager.startUpdatingLocation()
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
        let settingAction = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(setting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel){ _ in
            self.setRegion(center: self.center)
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

extension RestaurantLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate.latitude, coordinate.longitude)
            setRegion(center: coordinate)
        }
        //한번만 업데이트
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
        setRegion(center: center)
        
    }
    
    //권한 변경 14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.checkDeviceLocationAuthorization()
        }
    }
    
    //권한 변경 14-
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkDeviceLocationAuthorization()
    }
}
