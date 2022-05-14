//
//  RegisterViewController.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 13/05/2022.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        guard let email = txtEmail.text, let password = txtPassword.text, let name = txtName.text,
              email.count > 0, password.count >= 6, name.count > 0 else {
            showErrorAlert(error: "Vui lòng nhập đầy đủ thông tin để đăng ký")
            return
        }
        let user = User(email: email, password: password, name: name)
        UserServices.shared.saveUser(user: user, completion: {statusCode in
            if statusCode == 1{
                DatabaseManager.shared.saveDataToCoreData(user: user)
                let chatroomVC = UIStoryboard(name: K.Storyboard.Tabbar, bundle: nil).instantiateViewController(withIdentifier: "MainTabbar")
                chatroomVC.modalPresentationStyle = .fullScreen
                self.present(chatroomVC, animated: true, completion: nil)
            } else {
                self.showErrorAlert(error: "Email đã tồn tại")
            }
        })
    }
    
    @IBAction func btnSwapToLoginClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: K.Storyboard.Main, bundle: nil)
        let loginVC = sb.instantiateViewController(identifier: K.ViewController.LoginViewController)
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}

extension RegisterViewController {
    private func setupUI() {
        btnRegister.layer.cornerRadius = 5
    }
    
    private func setupBinding() {
        
    }
}
