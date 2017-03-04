//
//  UserTextOnlyCell.swift
//  Shop
//
//  Created by Donovan Cotter on 2/26/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit

class UserTextOnlyCell: UITableViewCell {
    @IBOutlet weak var messageTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCellAttributes(withMessage message: TextOnlyMessage, business: Business) {
            setMessageTextView(withText: message.text)
    }
    
    func setMessageTextView(withText text: String) {
        self.messageTextView.text = text
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.messageTextView.text = nil
        self.messageTextView.sizeToFit()
    }

}
