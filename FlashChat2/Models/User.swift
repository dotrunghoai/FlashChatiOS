//
//  User.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 13/05/2022.
//

class User {
    var email: String = ""
    var password: String = ""
    var name: String = ""
    
    init(email: String, password: String, name: String) {
        self.email = email
        self.password = password
        self.name = name
    }
    
    init() {}
}
