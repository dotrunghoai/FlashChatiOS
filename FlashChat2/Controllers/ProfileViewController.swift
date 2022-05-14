//
//  ProfileViewController.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let user = DatabaseManager.shared.getDataFromCoreData() {
            lblName.text = user.email
        }
    }
    
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        DatabaseManager.shared.removeDataFromCoreData {
            let sb = UIStoryboard(name: K.Storyboard.Main, bundle: nil)
            let loginVC = sb.instantiateViewController(identifier: K.ViewController.LoginViewController)
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        }
    }
}

extension ProfileViewController {
    func setupUI() {
        btnLogout.layer.cornerRadius = 5
    }
}
