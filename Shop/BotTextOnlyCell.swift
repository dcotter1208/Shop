//
//  BotTextOnlyCell.swift
//  Shop
//
//  Created by Donovan Cotter on 2/18/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit

typealias messageTuple = (message: Message, business: Business)

class BotTextOnlyCell: UITableViewCell {
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellAttributes(withMessage message: (messageTuple)) {
        if let text = message.message.text {
            setMessageTextView(withText: text)
        }
        
        setLogoImageVIew(logo: message.business.logo)
    }
    
    func setMessageTextView(withText text: String) {
        self.messageTextView.text = text
    }
    
    func setLogoImageVIew(logo: UIImage) {
        DispatchQueue.main.async {
            self.logoImageView.image = logo
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.messageTextView.text = nil
        self.messageTextView.sizeToFit()
    }
    

}
