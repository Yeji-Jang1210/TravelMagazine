//
//  AdDetailViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/29/24.
//

import UIKit

class AdDetailViewController: UIViewController {
    
    static let identifier: String = "AdDetailViewController"
    
    @IBOutlet var contentLabel: UILabel!
    var content: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        contentLabel.text = content
        contentLabel.numberOfLines = 0
    }
    
    private func configureNavigationItem(){
        navigationItem.title = Localized.city_ad_navigation_title.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: IconManager.xMark.icon, style: .plain, target: self, action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func dismissButtonTapped(_ sender: UIButton){
        //present로 띄웠으니 뒤로갈때는 dismiss로!!
        dismiss(animated: true)
    }
}
