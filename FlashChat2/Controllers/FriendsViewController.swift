//
//  FriendsViewController.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import UIKit

class FriendsViewController: UIViewController {
    @IBOutlet weak var tbvUsers: UITableView!
    
    var users = [User]()
    let myEmail = DatabaseManager.shared.getDataFromCoreData()?.email

    override func viewDidLoad() {
        super.viewDidLoad()
        tbvUsers.dataSource = self
        tbvUsers.delegate = self
        
        UserServices.shared.getAllUsersNotMe(myEmail: myEmail!, completion: { users in
            self.users = users
            self.tbvUsers.reloadData()
        })
    }
}

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Tabbar", bundle: nil)
        let messageDetailVC = sb.instantiateViewController(identifier: "MessageDetailViewController") as! MessageDetailViewController
        messageDetailVC.modalPresentationStyle = .fullScreen
        messageDetailVC.user = users[indexPath.row]
        messageDetailVC.myEmail = myEmail!
        present(messageDetailVC, animated: true, completion: nil)
    }
}
