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
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var countrySegmentedControl: UISegmentedControl!
    
    var list = CityInfo().city
    lazy var filteredList: [City] = list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSegmentControl()
        
        searchBar.searchTextField.addTarget(self, action: #selector(searchText), for: .editingDidEndOnExit)
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        let xib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
    }
    
    private func configureSegmentControl(){
        for item in Country.allCases {
            countrySegmentedControl.setTitle(item.title, forSegmentAt: item.rawValue)
        }
        
        countrySegmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    @objc func searchText(_ sender: UISearchBar){
        guard let text = searchBar.text?.lowercased() else {
            return
        }
        
        filteredCountry(index: countrySegmentedControl.selectedSegmentIndex)
        
        //아무것도 입력하지 않은 경우
        if text.isEmpty { 
            tableView.reloadData()
            return }
        
        var searchResult = filteredList.filter({$0.city_name.lowercased().contains(text) ||
            $0.city_english_name.lowercased().contains(text) ||
            $0.city_explain.lowercased().contains(text)})
        
        filteredList = searchResult
        
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl){
        print(sender.selectedSegmentIndex)
        filteredCountry(index: sender.selectedSegmentIndex)
        searchBar.text = ""
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    
    private func filteredCountry(index: Int){
        switch index {
        case 0:
            filteredList = list
        case 1:
            filteredList = list.filter({$0.domestic_travel})
        case 2:
            filteredList = list.filter({!$0.domestic_travel})
        default:
            filteredList = list
        }
    }
}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as! PopularCityTableViewCell
        cell.setData(data: filteredList[indexPath.row], searchText: searchBar.text)
        
        return cell
    }
    
}
