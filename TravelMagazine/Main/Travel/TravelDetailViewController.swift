//
//  TravelDetailViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 5/29/24.
//

import UIKit
import Kingfisher
import Cosmos

class TravelDetailViewController: UIViewController {
    
    static let identifier: String = "TravelDetailViewController"
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var starRateView: CosmosView!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureLayout()
        setData()
    }
    
    private func configureNavigationItem(){
        navigationItem.title = "관광지 화면"
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(dismissButtonTapped))
        backButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    private func configureLayout(){
        photoImageView.backgroundColor = .systemGray6
        photoImageView.contentMode = .scaleAspectFill
    }
    
    @objc func dismissButtonTapped(_ sender: UIButton){
        //navigationController.push로 띄웠기 때문에 pop으로!
        navigationController?.popViewController(animated: true)
    }
    
    private func setData(){
        guard let data else {
            let alert = UIAlertController(title: "오류", message: "데이터를 불러오는데 실패했습니다", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "확인", style: .default){ _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(dismissAction)
            present(alert,animated: true)
            return
        }
        
        if let urlStr = data.travel_image, let url = URL(string: urlStr) {
            photoImageView.kf.setImage(with: url)
        }
        titleLabel.text = data.title
        starRateView.rating = data.grade ?? 0
        gradeLabel.text = data.reviewText
        descriptionLabel.text = data.description ?? ""
    }
}
