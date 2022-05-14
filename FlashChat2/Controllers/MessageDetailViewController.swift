//
//  MessageDetailViewController.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import Foundation
import UIKit
import SocketIO

class MessageDetailViewController: UIViewController {
    @IBOutlet weak var txtMessageContent: UITextField!
    @IBOutlet weak var tbvMessageDetail: UITableView!
    @IBOutlet weak var lblName: UILabel!
    
    var user = User()
    var messages = [Message]()
    var myEmail: String = ""
    
    let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .compress])
    var socket: SocketIOClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        tbvMessageDetail.dataSource = self
        tbvMessageDetail.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        
        lblName.text = user.name
        loadMessage()
        
        socket = manager.defaultSocket
        socket.connect()
        socket.on("sendResponse") { data, ack in
            let json = data[0] as! NSDictionary
            let sender = json["sender"] as! String
            let receiver = json["receiver"] as! String
            let content = json["content"] as! String
            let message = Message(sender: sender, receiver: receiver, content: content)
            self.messages.append(message)
            self.tbvMessageDetail.reloadData()
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.tbvMessageDetail.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSendMessageClicked(_ sender: UIButton) {
        if let content = txtMessageContent.text, content.count > 0 {
            socket.emit("sendMessage", [
                "sender": myEmail,
                "receiver": user.email,
                "content": content
            ])
            txtMessageContent.text = ""
        }
    }
}

extension MessageDetailViewController: UITableViewDataSource {
    func loadMessage() {
        MessageServices.shared.getMessages(myEmail: myEmail, yourEmail: user.email) { messages in
            self.messages = messages
            self.tbvMessageDetail.reloadData()
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.tbvMessageDetail.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MessageTableViewCell
        cell.lblLabel.text = message.content
        if message.sender == myEmail {
            cell.imgAvatarLeft.isHidden = true
            cell.imgAvatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.lblLabel.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.imgAvatarLeft.isHidden = false
            cell.imgAvatar.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.lblLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
}
