//
//  TravelViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/27/24.
//

import UIKit

class TravelViewController: UIViewController {

    var list = TravelInfo.init().travel
    
    @IBOutlet var travelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let travelNib = UINib(nibName: TravelTableViewCell.identifier, bundle: nil)
        let adNib = UINib(nibName: "AdTableViewCell", bundle: nil)
        travelTableView.register(travelNib, forCellReuseIdentifier: TravelTableViewCell.identifier)
        travelTableView.register(adNib, forCellReuseIdentifier: AdTableViewCell.identifier)
        travelTableView.delegate = self
        travelTableView.dataSource = self
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        if let like = list[sender.tag].like {
            list[sender.tag].like = !like
        }
        travelTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}

extension TravelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return list[indexPath.row].ad ? 80 : 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = list[indexPath.row]
        if data.ad {
            let cell = travelTableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            cell.setLayout(title: data.title, hexCode: AdColor.allCases.randomElement()!)
            return cell
        }
        
        let cell = travelTableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.setLayout(data: data)
        return cell
        
    }
}
