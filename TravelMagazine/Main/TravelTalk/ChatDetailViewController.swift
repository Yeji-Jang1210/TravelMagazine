//
//  ChatDetailViewController.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/1/24.
//

import UIKit

class ChatDetailViewController: UIViewController {
    
    static let identifier: String = String(describing: ChatDetailViewController.self)
    
    @IBOutlet var chatBackgroundView: UIView!
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var chatTextView: UITextView!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var chatPlaceholder: UILabel!
    
    public var chatRoom: ChatRoom? {
        didSet {
            if let chatRoom {
                chatList = chatRoom.chatList
            }
        }
    }
    
    public lazy var chatList: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        configureTableView()
    }
    
    private func configureTableView(){
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.allowsSelection = false
        
        let userXib = UINib(nibName: UserChatBubble.identifier, bundle: nil)
        let otherXib = UINib(nibName: OtherChatBubble.identifier, bundle: nil)
        
        chatTableView.register(userXib, forCellReuseIdentifier: UserChatBubble.identifier)
        chatTableView.register(otherXib, forCellReuseIdentifier: OtherChatBubble.identifier)
    }
    
}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chatList[indexPath.row].user == .user {
            let cell = chatTableView.dequeueReusableCell(withIdentifier: UserChatBubble.identifier, for: indexPath) as! UserChatBubble
            cell.fetchData(chatList[indexPath.row])
            return cell
        }
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: OtherChatBubble.identifier, for: indexPath) as! OtherChatBubble
        cell.fetchData(chatList[indexPath.row])
        return cell
    }
}
