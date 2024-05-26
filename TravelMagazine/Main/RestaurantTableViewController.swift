//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/26/24.
//

import UIKit



class RestaurantTableViewController: UITableViewController {

    @IBOutlet var searchBackground: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var categoryButton: UIButton!
    @IBOutlet var priceButton: UIButton!
    @IBOutlet var likedRestaurantListButton: UIButton!
    
    var controller = RestaurantManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 383
        
        setSearchUI()
        setMenuButtonUI()
    }
    
    func setSearchUI(){
        searchBackground.layer.cornerRadius = searchBackground.frame.height / 2
        searchTextField.addTarget(self, action: #selector(searchRestaurant), for: .editingDidEnd)
        searchButton.addTarget(self, action: #selector(searchRestaurant), for: .touchUpInside)
    }
    
    func setMenuButtonUI(){
        //categoryButton
        var categoryMenuActions: [UIAction] = []
        for category in FoodCategory.allCases {
            let action = UIAction(title: category.rawValue, handler: categoryTapped)
            categoryMenuActions.append(action)
        }
        categoryButton.menu = UIMenu(title: "음식종류", options: .displayInline, children: categoryMenuActions)
        //버튼을 길게 누르지 않고 탭만 하면 나오게끔 하는 속성
        categoryButton.showsMenuAsPrimaryAction = true
        
        //priceButton
        var priceMenuActions: [UIAction] = []
        for order in OrderPrice.allCases {
            let action = UIAction(title: order.rawValue, handler: orderPriceTapped)
           priceMenuActions.append(action)
        }
        
        priceButton.menu = UIMenu(title: "가격", options: .displayInline, children: priceMenuActions)
        priceButton.showsMenuAsPrimaryAction = true
    }
    
    @objc func searchRestaurant(_ sender: Any){
        guard let text = searchTextField.text, !text.isEmpty else { return }
        
        controller.searchRestaurantName(text)
        searchTextField.text = ""
        view.endEditing(true)
        tableView.reloadData()
    }
    
    func categoryTapped(_ sender: UIAction){
        categoryButton.setTitle(sender.title, for: .normal)
        controller.category = FoodCategory(rawValue: sender.title) ??  .all
        tableView.reloadData()
    }
    
    func orderPriceTapped(_ sender: UIAction){
        priceButton.setTitle(sender.title, for: .normal)
        controller.orderPrice = OrderPrice(rawValue: sender.title) ?? nil
        tableView.reloadData()
    }
    
    @IBAction func likeListButtonTapped(_ sender: UIButton) {
        controller.isLikeListButtonTapped.toggle()
        likedRestaurantListButton.setTitle(controller.isLikeListButtonTapped ? "전체보기" : "즐겨찾기", for: .normal)
        controller.getLikedRestaurant()
        tableView.reloadData()
    }
    
    
    @objc func likeButtonTapped(_ sender: UIButton){
        let key = controller.list[sender.tag].name
        controller.likeList[key]?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}

extension RestaurantTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = controller.list[indexPath.row]
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.setUI(image: restaurant.image, title: restaurant.name, type: restaurant.category, address: restaurant.address, phoneNumber: restaurant.phoneNumber, price: restaurant.price, liked: controller.likeList[restaurant.name])
        
        return cell
        
    }
}

