//
//  ShowMessage.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 14/05/2022.
//

import UIKit

public extension UIViewController {
    func showErrorAlert(error: String = "Đã có lỗi xảy ra :(") {
        let alert = UIAlertController(title: "Thông báo", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Hủy", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
