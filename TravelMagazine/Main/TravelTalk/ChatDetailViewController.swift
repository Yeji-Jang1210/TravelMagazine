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
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var chatPlaceholder: UILabel!
    
//MARK: properties
    var isTextViewEmpty: Bool = true {
        didSet {
            chatPlaceholder.text = isTextViewEmpty ? Localized.travelTalk_messageTextView_placeholder.text : nil
        }
    }
    
    lazy var textViewYValue: CGFloat = 34
    
    public var chatRoom: ChatRoom? {
        didSet {
            if let chatRoom {
                chatList = chatRoom.chatList
            }
        }
    }
    
    public lazy var chatList: [Chat] = []
    
    deinit {
        removeKeyboardNotifications()
    }
    
//MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chatTableView.scrollToRow(at: IndexPath(row: chatList.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    private func configureUI(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(gesture)
        configureNavigationBar()
        configureTableView()
        configureTextField()
        registerKeyboardNotifications()
    }
    
    private func registerKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDismiss(){
        view.endEditing(true)
    }
    
    private func configureNavigationBar(){
        let dismissButton = UIBarButtonItem(image: IconManager.backButton.icon, style: .done, target: self, action: #selector(backButtonTapped))
        dismissButton.tintColor = .label
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.title = chatRoom?.chatroomName
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
    
    private func configureTextField(){
        //button
        sendButton.setImage(IconManager.sendButton.icon, for: .normal)
        sendButton.tintColor = .lightGray
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        //background
        chatBackgroundView.backgroundColor = .systemGray6
        chatBackgroundView.layer.cornerRadius = 12
        
        //textView
        messageTextView.delegate = self
        messageTextView.backgroundColor = .clear
        
        //placeholder
        isTextViewEmpty = true
        chatPlaceholder.textColor = .lightGray
    }
    
    @objc func backButtonTapped(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func sendMessage(_ sender: UIButton){
        guard let date = Date.now.convertDateToString(ChatManager.chatDataDateFormat) else {
            presentErrorAlert()
            return
        }
        
        chatRoom?.chatList.append(Chat(user: .user, date: date, message: messageTextView.text))
        messageTextView.text = ""
        isTextViewEmpty = true
        
        chatTableView.reloadData()
        chatTableView.scrollToRow(at: IndexPath(row: chatList.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    private func presentErrorAlert(){
        let alert = UIAlertController(title: Localized.travelTalk_sendMessage_error.title, message: Localized.travelTalk_sendMessage_error.subtitle, preferredStyle: .alert)
        
        let errorAction = UIAlertAction(title: Localized.travelTalk_sendMessage_error.confirmText, style: .cancel)
        alert.addAction(errorAction)
        
        present(alert, animated: true)
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

extension ChatDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        isTextViewEmpty = textView.text.isEmpty
    }
}

//keyboard Actions
extension ChatDetailViewController {
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardHeight = keyboardFrame.cgRectValue.height

            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardHeight
            }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        view.frame.origin.y = 0
    }
}
