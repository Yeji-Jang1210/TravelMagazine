//
//  AdDetailViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/29/24.
//

import UIKit

class AdDetailViewController: UIViewController {
    
    static let identifier: String = "AdDetailViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
    }
    
    private func configureNavigationItem(){
        navigationItem.title = "광고화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func dismissButtonTapped(_ sender: UIButton){
        //present로 띄웠으니 뒤로갈때는 dismiss로!!
        dismiss(animated: true)
    }
}
