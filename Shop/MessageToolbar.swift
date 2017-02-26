//
//  MessageToolbar.swift
//  Shop
//
//  Created by Donovan Cotter on 2/18/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit

protocol MessageToolbarDelegate {
    func sendMessage()
}

class MessageToolbar: UIView {
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet var view: UIView!
    
    var delegate: MessageToolbarDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("MessageToolbar", owner: self, options: nil)
        view.frame = self.bounds
        messageTextView.layer.cornerRadius = 5
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func sendMessageSelected(_ sender: Any) {
        self.delegate?.sendMessage()
    }
    
    
}
