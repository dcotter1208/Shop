//
//  BotTextOnlyCell.swift
//  Shop
//
//  Created by Donovan Cotter on 2/18/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit

class BotTextOnlyCell: UITableViewCell {
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellAttributes(withMessage message: TextOnlyMessage, business: Business) {
        setMessageTextView(withText: message.text)
        setLogoImageVIew(logo: business.logo)
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
