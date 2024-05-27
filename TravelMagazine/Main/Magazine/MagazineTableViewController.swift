//
//  MagazineTableViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/25/24.
//

import UIKit

class MagazineTableViewController: UITableViewController {
    
    var navigationItemImageView: UIImageView {
        let object = UIImageView()
        object.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        object.image = UIImage(systemName: "ellipsis")
        object.contentMode = .scaleAspectFit
        object.tintColor = .lightGray
        return object
    }
    
    var navigationItemTitle: UILabel {
        let object = UILabel()
        object.font = .systemFont(ofSize: 17, weight: .bold)
        object.text = "SeSAC TRAVEL"
        return object
    }
    
    var magazines = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        let stackView = UIStackView(arrangedSubviews: [navigationItemImageView, navigationItemTitle])
        stackView.axis = .vertical
        
        navigationItem.titleView = stackView
    }
    
    private func convertStringToDate(_ text: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyMMdd"
        
        return dateFormat.date(from: text)
    }
    
    func setDateFormat(date: String) -> String {
        guard let date = convertStringToDate(date) else {
            return ""
        }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yy년 MM월 dd일"
        return dateFormat.string(from: date)
    }
    
}

extension MagazineTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.identifier, for: indexPath) as! MagazineTableViewCell
        
        let magazine = magazines[indexPath.row]
        cell.setUI(image: magazine.photo_image, title: magazine.title, subtitle: magazine.subtitle, date: setDateFormat(date: magazine.date))
        
        
        return cell
        
    }
}

