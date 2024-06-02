//
//  TravelTalkViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/1/24.
//

import UIKit

class TravelTalkViewController: UIViewController {
    
    @IBOutlet var talkListTableView: UITableView!
    @IBOutlet var searchBackgroundView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    lazy var talkList = mockChatList {
        didSet {
            talkListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        navigationItem.title = "TRAVEL TALK"
        configureTableView()
        configureSearchObjects()
    }
    
    private func configureTableView(){
        let xib = UINib(nibName: TravelTalkTableViewCell.identifier, bundle: nil)
        
        talkListTableView.rowHeight = 80
        talkListTableView.separatorStyle = .none
        talkListTableView.delegate = self
        talkListTableView.dataSource = self
        talkListTableView.register(xib, forCellReuseIdentifier: TravelTalkTableViewCell.identifier)
    }
    
    private func configureSearchObjects(){
        
        searchBackgroundView.backgroundColor = .systemGray6
        searchBackgroundView.layer.cornerRadius = 10
        
        searchTextField.borderStyle = .none
        searchTextField.placeholder = "친구 이름을 검색해보세요"
        searchTextField.addTarget(self, action: #selector(searchChatRoom), for: .editingDidEndOnExit)
        searchTextField.addTarget(self, action: #selector(resetTextField), for: .editingDidBegin)
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .lightGray
        searchButton.addTarget(self, action: #selector(searchChatRoom), for: .touchUpInside)
    }
    
    @objc func searchChatRoom(_ sender: Any?){
        guard let keyword = searchTextField.text, !keyword.isEmpty else {
            talkList = mockChatList
            return
        }
        
        talkList = mockChatList.filter { $0.chatList.contains { chat in
                chat.user.rawValue.lowercased().contains(keyword.lowercased())
            }
        }

        view.endEditing(true)
    }
    
    @objc func resetTextField(){
        searchTextField.text = ""
    }
}

extension TravelTalkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = talkListTableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier, for: indexPath) as! TravelTalkTableViewCell
        
        cell.fetchData(talkList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ChatDetailViewController.identifier) as! ChatDetailViewController
        vc.chatRoom = talkList[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
