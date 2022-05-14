//
//  ViewController.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 13/05/2022.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    private let loginViewModel = LoginViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if DatabaseManager.shared.getDataFromCoreData() != nil {
            let chatroomVC = UIStoryboard(name: K.Storyboard.Tabbar, bundle: nil).instantiateViewController(withIdentifier: "MainTabbar")
            chatroomVC.modalPresentationStyle = .fullScreen
            self.present(chatroomVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
//        guard let email = txtEmail.text, let password = txtPassword.text,
//              email.count > 0, password.count > 0 else {
//            showErrorAlert(error: "Vui lòng nhập đầy đủ thông tin để đăng nhập")
//            return
//        }
        let email = txtEmail.text!
        let password = txtPassword.text!
        let user = User(email: email, password: password, name: "")
        UserServices.shared.login(user: user, completion: { resultCode in
            if resultCode == 1{
                DatabaseManager.shared.saveDataToCoreData(user: user)
                let chatroomVC = UIStoryboard(name: K.Storyboard.Tabbar, bundle: nil).instantiateViewController(withIdentifier: "MainTabbar")
                chatroomVC.modalPresentationStyle = .fullScreen
                self.present(chatroomVC, animated: true, completion: nil)
            } else {
                self.showErrorAlert(error: "Tài khoản hoặc mật khẩu không đúng")
            }
        })
    }
    
    @IBAction func btnSwapToRegisterClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: K.Storyboard.Main, bundle: nil)
        let registerVC = sb.instantiateViewController(identifier: K.ViewController.RegisterViewController)
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true, completion: nil)
    }
}

private extension LoginViewController {
    private func setupUI() {
        btnLogin.layer.cornerRadius = 5
    }
    
    private func setupBinding() {
        txtEmail.rx.text.map({ $0 ?? "" })
            .bind(to: loginViewModel.txtEmailPublishSubject)
            .disposed(by: bag)
        txtPassword.rx.text.map({ $0 ?? "" })
            .bind(to: loginViewModel.txtPasswordPublishSubject)
            .disposed(by: bag)
        loginViewModel.isValid()
            .bind(to: btnLogin.rx.isEnabled)
            .disposed(by: bag)
        loginViewModel.isValid().map({ $0 ? 1 : 0.1 })
            .bind(to: btnLogin.rx.alpha)
            .disposed(by: bag)
    }
}
