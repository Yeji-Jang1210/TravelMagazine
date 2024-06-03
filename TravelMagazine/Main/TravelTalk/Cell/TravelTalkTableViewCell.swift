//
//  TravelTalkTableViewCell.swift
//  TravelMagazine
//
//  Created by 장예지 on 6/1/24.
//

import UIKit

class TravelTalkTableViewCell: UITableViewCell {
    
    static var identifier = String(describing: TravelTalkTableViewCell.self)
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var talkLabel: UILabel!
    
    @IBOutlet var threePeopleChatRoomView: UIView!
    @IBOutlet var fourPeopleOverChatRoomView: UIView!
    
    @IBOutlet var threePeopleImageView: [UIImageView]!
    @IBOutlet var fourPeopleOverImageView: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reLoadUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        threePeopleChatRoomView.isHidden = true
        fourPeopleOverChatRoomView.isHidden = true
    }
    
    private func reLoadUI(){
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        threePeopleChatRoomView.layer.cornerRadius = profileImageView.layer.cornerRadius
        fourPeopleOverChatRoomView.layer.cornerRadius = profileImageView.layer.cornerRadius
    }
    
    private func configureUI(){
        profileImageView.image = IconManager.emptyProfile.icon
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .systemGray4
        
        nicknameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        talkLabel.font = .systemFont(ofSize: 14)
        talkLabel.textColor = .systemGray2
        
        dateLabel.textColor = .systemGray4
        dateLabel.font = .systemFont(ofSize: 14)
        
        setChatRoomImageContentMode(threePeopleImageView)
        setChatRoomImageContentMode(fourPeopleOverImageView)
        threePeopleChatRoomView.clipsToBounds = true
        fourPeopleOverChatRoomView.clipsToBounds = true
    }
    
    private func setChatRoomImageContentMode(_ chatRoomImages: [UIImageView]){
        for chatRoomImage in chatRoomImages {
            chatRoomImage.contentMode = .scaleAspectFill
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func fetchData(_ data: ChatRoom){
        setChatRoomImage(imageList: data.chatroomImage)
        nicknameLabel.text = data.chatroomName
        talkLabel.text = data.chatList.last?.message
        dateLabel.text = data.chatRoomDate
    }
    
    private func setChatRoomImage(imageList: [String]){
        switch imageList.count {
        case 0:
            return
        case 1...2:
            if let image = imageList.first {
                profileImageView.image = UIImage(named: image)
            }
        case 3:
            threePeopleChatRoomView.isHidden = false
            fourPeopleOverChatRoomView.isHidden = true
            setProfiles(imageList, threePeopleImageView)
        default:
            threePeopleChatRoomView.isHidden = true
            fourPeopleOverChatRoomView.isHidden = false
            setProfiles(imageList, fourPeopleOverImageView)
        }
    }
    
    private func setProfiles(_ list: [String], _ imageViews: [UIImageView]){
        for index in imageViews.indices {
            if let image = UIImage(named: list[index]){
                imageViews[index].image = image
            }
        }
    }
}
