//
//  RestaurantLocationViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/30/24.
//

import UIKit
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
    
    var list: [Restaurant] = RestaurantList().restaurantArray
    lazy var filteredList: [Restaurant] = list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureMapView()
        fetchMapAnnotations()
    }
    
    func configureNavigationItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
    }
    
    func configureMapView(){
        let center = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
    }
    
    func fetchMapAnnotations(){
        var annotations: [MKAnnotation] = []
        
        for item in filteredList {
            let annotation = CustomAnnotation(title: item.mapViewTitle, subTitle: item.address, latitude: item.latitude, longitude: item.longitude)
            annotations.append(annotation)
        }
        
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
