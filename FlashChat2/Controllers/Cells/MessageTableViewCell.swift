//
//  MessageTableViewCell.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 15/05/2022.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var lblLabel: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgAvatarLeft: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
