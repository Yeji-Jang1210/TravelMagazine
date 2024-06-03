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
        configureTableView()
    }
    
    private func configureTableView(){
        travelTableView.rowHeight = UITableView.automaticDimension
        travelTableView.delegate = self
        travelTableView.dataSource = self
        
        let travelNib = UINib(nibName: TravelTableViewCell.identifier, bundle: nil)
        let adNib = UINib(nibName: "AdTableViewCell", bundle: nil)
        
        travelTableView.register(travelNib, forCellReuseIdentifier: TravelTableViewCell.identifier)
        travelTableView.register(adNib, forCellReuseIdentifier: AdTableViewCell.identifier)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        if let like = list[sender.tag].like {
            list[sender.tag].like = !like
            travelTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        }
    }
}

extension TravelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list[indexPath.row]
        
        if data.ad {
            let cell = travelTableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            cell.setLayout(title: data.title)
            return cell
        }
        
        let cell = travelTableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.setLayout(data: data)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let share = UIContextualAction(style: .normal, title: Localized.city_swipe_left.title) { (actin, view, completion) in
            completion(true)
        }
        
        share.image = IconManager.arrowUturnLeft.icon
        share.backgroundColor = UIColor(hexCode: "B2DDFB")
        return UISwipeActionsConfiguration(actions: [share])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !list[indexPath.row].ad {
            
            let delete = UIContextualAction(style: .destructive, title: Localized.city_swipe_right.title) { (actin, view, completion) in
                self.list.remove(at: indexPath.row)
                self.travelTableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                completion(true)
            }
            
            delete.image = IconManager.trash.icon
            
            return UISwipeActionsConfiguration(actions: [delete])
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        if !data.ad {
            let vc = storyboard?.instantiateViewController(withIdentifier: TravelDetailViewController.identifier) as! TravelDetailViewController
            vc.data = data
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: AdDetailViewController.identifier) as! AdDetailViewController
            vc.content = data.title
            
            let nvc = UINavigationController(rootViewController: vc)
            nvc.modalPresentationStyle = .fullScreen
            nvc.modalTransitionStyle = .coverVertical
            
            present(nvc, animated: true)
            
        }
    }
}
