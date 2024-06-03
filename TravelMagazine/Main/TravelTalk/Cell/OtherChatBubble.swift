//
//  OtherChatBubble.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/1/24.
//

import UIKit

class OtherChatBubble: UITableViewCell {
    
    static var identifier: String = String(describing: OtherChatBubble.self)
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
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
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .lightGray
        profileImageView.image = IconManager.emptyProfile.icon
        
        nicknameLabel.text = nil
        nicknameLabel.font = ChatManager.nicknameFont
        
        chatBubbleBackground.backgroundColor = ChatManager.otherChatBubbleColor
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
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        chatBubbleBackground.layer.cornerRadius = ChatManager.chatBubbleCornerRadius
    }
    
    public func fetchData(_ bubble: Chat){
        profileImageView.image = UIImage(named: bubble.user.profileImage)
        nicknameLabel.text = bubble.user.rawValue
        messageLabel.text = bubble.message
        timeLabel.text = bubble.chatBubbleTime
    }
}
