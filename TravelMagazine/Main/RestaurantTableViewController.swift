//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/26/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    @IBOutlet var searchBackground: UIView!
    
    
    var list = RestaurantList().restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 383
        
        searchBackground.layer.cornerRadius = searchBackground.frame.height / 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        let restaurant = list[indexPath.row]
        cell.setUI(image: restaurant.image, title: restaurant.name, type: restaurant.category, address: restaurant.address, phoneNumber: restaurant.phoneNumber, price: restaurant.price)
        
        return cell
        
    }
}
