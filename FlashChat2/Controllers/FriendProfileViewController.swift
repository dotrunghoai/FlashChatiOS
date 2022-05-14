//
//  FriendProfileViewController.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import UIKit

class FriendProfileViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnAddFriend: UIButton!
    var isFriend: Bool = false
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FriendProfileViewController {
    func setupUI() {
        btnAddFriend.layer.cornerRadius = 5
    }
}
