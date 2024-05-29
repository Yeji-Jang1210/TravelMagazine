//
//  PopularCityViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/29/24.
//

import UIKit

enum Country: Int, CaseIterable {
    case all = 0
    case domestic
    case international
    
    var title: String {
        switch self {
        case .all:
            return "전체"
        case .domestic:
            return "국내"
        case .international:
            return "해외"
        }
    }
}

class PopularCityViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var countrySegmentedControl: UISegmentedControl!
    
    var list = CityInfo().city
    lazy var filteredList: [City] = list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        for item in Country.allCases {
            countrySegmentedControl.setTitle(item.title, forSegmentAt: item.rawValue)
        }
        
        countrySegmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        let xib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl){
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            filteredList = list
        case 1:
            filteredList = list.filter({$0.domestic_travel})
        case 2:
            filteredList = list.filter({!$0.domestic_travel})
        default:
            filteredList = list
        }
        
        tableView.reloadData()
    }
}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as! PopularCityTableViewCell
        cell.setData(data: filteredList[indexPath.row])
        return cell
    }
    
    
}
