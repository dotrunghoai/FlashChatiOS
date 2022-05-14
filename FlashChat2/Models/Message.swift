//
//  Message.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 15/05/2022.
//

import Foundation

class Message {
    var sender: String = ""
    var receiver: String = ""
    var content: String = ""
    
    init(sender: String, receiver: String, content: String) {
        self.sender = sender
        self.receiver = receiver
        self.content = content
    }
    
    init() {}
}
