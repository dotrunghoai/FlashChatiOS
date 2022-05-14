//
//  HttpService.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import Foundation
import UIKit
import Alamofire

class UserServices {
    public static let shared = UserServices()
    let httpUrl = "http://localhost:3000"
    
    func saveUser(user: User, completion: @escaping(_ resultCode: Int) -> Void) {
        let realURL: URL = URL(string: "\(httpUrl)/add")!
        let url: Alamofire.URLConvertible = realURL
        let parameters: [String: Any] = [
            "email" : user.email,
            "password" : user.password,
            "name" : user.name
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: nil).responseData { response in
            if let data = response.data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                completion(json!["resultCode"] as! Int)
            }
        }
        completion(0)
    }
    
    func login(user: User, completion: @escaping(_ resultCode: Int) -> Void) {
        let realURL: URL = URL(string: "\(httpUrl)/login")!
        let url: Alamofire.URLConvertible = realURL
        let parameters: [String: Any] = [
            "email" : user.email,
            "password" : user.password
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: nil).responseJSON { response in
            //to get status code
//            if let status = response.response?.statusCode {
//                switch(status){
//                case 201:
//                    print("example success")
//                default:
//                    print("error with response status: \(status)")
//                }
//            }
            
            //to get JSON return value
            if let data = response.data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                completion(json!["resultCode"] as! Int)
            }
        }
    }
    
    func getAllUsers(completion: @escaping() -> Void) {
//        let realURL: URL = URL(string: "\(httpUrl)/login")!
//        let url: Alamofire.URLConvertible = realURL
//        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: nil).responseJSON { response in
//            if let data = response.data {
//                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
//                print(json)
//                completion()
//            }
//        }
        
        let request = Alamofire.request("\(httpUrl)/")
        request.responseJSON { (data) in
          print(data)
        }
    }
    
    func getAllUsersNotMe(myEmail: String, completion: @escaping(_ users: [User]) -> Void) {
        let realURL: URL = URL(string: "\(httpUrl)/notMyEmail")!
        let url: Alamofire.URLConvertible = realURL
        let parameters: [String: Any] = [
            "email" : myEmail
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: nil).responseData { response in
            if let data = response.data {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rows = json!["users"] as! [AnyObject]
                var users = [User]()
                for row in rows {
                    let email = row["email"] as! String
                    let name = row["name"] as! String
                    users.append(User(email: email, password: "", name: name))
                }
                completion(users)
            }
        }
    }
}
