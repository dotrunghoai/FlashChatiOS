//
//  MessageServices.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import Foundation
import Alamofire

class MessageServices {
    public static let shared = MessageServices()
    let httpUrl = "http://localhost:3000"
    
    func getMessages(myEmail: String, yourEmail: String, completion: @escaping(_ message: [Message]) -> Void) {
        let realURL: URL = URL(string: "\(httpUrl)/getMessage")!
        let url: Alamofire.URLConvertible = realURL
        let parameters: [String: Any] = [
            "myEmail" : myEmail,
            "yourEmail": yourEmail
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: nil).responseData { response in
            if let data = response.data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rows = json!["messages"] as! [AnyObject]
                var messages = [Message]()
                for row in rows {
                    let sender = row["myEmail"] as! String
                    let receiver = row["yourEmail"] as! String
                    let content = row["message"] as! String
                    messages.append(Message(sender: sender, receiver: receiver, content: content))
                }
                completion(messages)
            }
        }
    }
}
