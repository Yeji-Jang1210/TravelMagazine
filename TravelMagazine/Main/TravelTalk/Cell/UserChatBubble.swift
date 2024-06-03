//
//  UserChatBubble.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/1/24.
//

import UIKit

class UserChatBubble: UITableViewCell {
    
    static var identifier: String = String(describing: UserChatBubble.self)
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var chatBubbleBackground: UIView!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reloadUI()
    }
    
    private func configureUI(){
        chatBubbleBackground.backgroundColor = ChatManager.userChatBubbleColor
        chatBubbleBackground.layer.borderWidth = ChatManager.chatBubbleBorderWidth
        chatBubbleBackground.layer.borderColor = ChatManager.chatBubbleBorderColor
        
        messageLabel.text = nil
        messageLabel.font = ChatManager.chatFont
        messageLabel.numberOfLines = 0
        
        timeLabel.text = nil
        timeLabel.textColor = ChatManager.timeFontColor
        timeLabel.font = ChatManager.timeFont
    }
    
    private func reloadUI(){
        chatBubbleBackground.layer.cornerRadius = ChatManager.chatBubbleCornerRadius
    }
    
    public func fetchData(_ bubble: Chat){
        messageLabel.text = bubble.message
        timeLabel.text = bubble.chatBubbleTime
    }
}

class ChatManager {
    static var nicknameFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    static var chatBubbleCornerRadius:CGFloat = 12
    static var chatBubbleBorderWidth:CGFloat = 1
    static var chatBubbleBorderColor = UIColor.darkGray.cgColor
    
    static var userChatBubbleColor = UIColor.systemGray6
    static var otherChatBubbleColor = UIColor.systemBackground
    
    static var chatFont = UIFont.systemFont(ofSize: 14)
    static var timeFont = UIFont.systemFont(ofSize: 12)
    static var timeFontColor = UIColor.darkGray
}
