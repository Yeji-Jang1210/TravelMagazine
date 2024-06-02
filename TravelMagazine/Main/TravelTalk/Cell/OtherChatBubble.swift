//
//  OtherChatBubble.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/1/24.
//

import UIKit

class OtherChatBubble: UITableViewCell {
    
    static var identifier: String = String(describing: OtherChatBubble.self)
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var chatBubbleBackground: UIView!
    @IBOutlet var chatBubbleTextView: UITextView!
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
        profileImageView.image = UIImage(named: "emptyProfile")
        
        nicknameLabel.text = nil
        nicknameLabel.font = ChatManager.nicknameFont
        
        chatBubbleBackground.backgroundColor = ChatManager.otherChatBubbleColor
        chatBubbleBackground.layer.borderWidth = ChatManager.chatBubbleBorderWidth
        chatBubbleBackground.layer.borderColor = ChatManager.chatBubbleBorderColor
        
        chatBubbleTextView.text = nil
        chatBubbleTextView.isScrollEnabled = false
        chatBubbleTextView.isEditable = false
        chatBubbleTextView.isSelectable = false
        chatBubbleTextView.font = ChatManager.chatFont
        
        timeLabel.text = nil
        timeLabel.textColor = ChatManager.timeFontColor
        timeLabel.font = ChatManager.timeFont
        
        chatBubbleBackground.backgroundColor = ChatManager.chatBubbleTextViewBackgroundColor
    }
    
    private func reloadUI(){
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        chatBubbleBackground.layer.cornerRadius = ChatManager.chatBubbleCornerRadius
    }
    
    public func fetchData(_ bubble: Chat){
        profileImageView.image = UIImage(named: bubble.user.profileImage)
        nicknameLabel.text = bubble.user.rawValue
        chatBubbleTextView.text = bubble.message
        timeLabel.text = bubble.chatBubbleTime
    }
}
