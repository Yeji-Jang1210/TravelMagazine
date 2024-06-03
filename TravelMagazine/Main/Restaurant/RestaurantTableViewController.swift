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
        setNavigationRightItem()
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
        categoryButton.menu = UIMenu(title: Localized.restaurant_categoryButton.text, options: .displayInline, children: categoryMenuActions)
        //버튼을 길게 누르지 않고 탭만 하면 나오게끔 하는 속성
        categoryButton.showsMenuAsPrimaryAction = true
        
        //priceButton
        var priceMenuActions: [UIAction] = []
        for order in OrderPrice.allCases {
            let action = UIAction(title: order.rawValue, handler: orderPriceTapped)
           priceMenuActions.append(action)
        }
        
        priceButton.menu = UIMenu(title: Localized.restaurant_priceButton.text, options: .displayInline, children: priceMenuActions)
        priceButton.showsMenuAsPrimaryAction = true
    }
    
    func setNavigationRightItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: IconManager.map.icon, style: .plain, target: self, action: #selector(presentMapView))
    }
    
    @objc func searchRestaurant(_ sender: Any){
        guard let text = searchTextField.text, !text.isEmpty else { return }
        
        controller.searchRestaurantName(text)
        searchTextField.text = ""
        view.endEditing(true)
        tableView.reloadData()
    }
    
    @objc func presentMapView(){
        let vc = storyboard?.instantiateViewController(identifier: RestaurantLocationViewController.identifier) as! RestaurantLocationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func categoryTapped(_ sender: UIAction){
        categoryButton.setTitle(sender.title, for: .normal)
        controller.category = FoodCategory(rawValue: sender.title) ?? .all
        tableView.reloadData()
    }
    
    func orderPriceTapped(_ sender: UIAction){
        priceButton.setTitle(sender.title, for: .normal)
        controller.orderPrice = OrderPrice(rawValue: sender.title) ?? nil
        tableView.reloadData()
    }
    
    @IBAction func likeListButtonTapped(_ sender: UIButton) {
        controller.isLikeListButtonTapped.toggle()
        likedRestaurantListButton.setTitle(controller.likeButtonTitle, for: .normal)
        tableView.reloadData()
    }
    
    
    @objc func likeButtonTapped(_ sender: UIButton){
        let key = controller.filteredList[sender.tag].name
        controller.likeList[key]?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
    @objc func phoneNumberButtonTapped(_ sender: UIButton){
        let alert = UIAlertController(title: Localized.restaurant_call_dlg.title, message: nil, preferredStyle: .actionSheet)
        
        let callAction = UIAlertAction(title: controller.list[sender.tag].phoneNumber, style: .default){ [weak self] action in
            guard let self else { return }
            print("📞 통화: \(controller.filteredList[sender.tag].phoneNumber)")
        }
        
        let cancelAction = UIAlertAction(title: Localized.restaurant_call_dlg.confirmText, style: .cancel)
        
        alert.addAction(callAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension RestaurantTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.filteredList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = controller.filteredList[indexPath.row]
        cell.likeButton.tag = indexPath.row
        cell.phoneNumberButton.tag = indexPath.row
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.phoneNumberButton.addTarget(self, action: #selector(phoneNumberButtonTapped), for: .touchUpInside)
        cell.setUI(data: restaurant, liked: controller.likeList[restaurant.name])
        
        return cell
        
    }
}

