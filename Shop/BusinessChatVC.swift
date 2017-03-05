//
//  BusinessChatVC.swift
//  Shop
//
//  Created by Donovan Cotter on 1/21/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit

fileprivate let kBotProductsResponseCellIdentifier = "BotProductsResponseCell"
fileprivate let kBotTextOnlyCellIdentifier = "BotTextOnlyCell"
fileprivate let kCurrentUserMessageCellIdentifier = "CurrentUserMessageCell"


class BusinessChatVC: UIViewController {
    @IBOutlet weak var chatTableView: UITableView!

    //MARK: Helper Vars
    var businessInContext = Business(name: "Best Buy", logo: UIImage()) //replace logo with placeholder value.
    fileprivate var messages = [MessageInfo]()
    fileprivate let firebaseOperation = FirebaseOperation()
    
    //MARK: MessageToolbar vars
    fileprivate let messageToolBarHeight:CGFloat = 44.0
    fileprivate var keyboardHeight: CGFloat?
    fileprivate var messageToolbar: MessageToolbar?
    fileprivate var selectTextView = true
    fileprivate var maxmessageToolBarHeight: CGFloat?
    fileprivate var keyboardAnimationDuration = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpmessageToolbar()
        setUpKeyboardNotification()
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 140
        chatTableView.keyboardDismissMode = .onDrag
        adjustTableViewInsetWithKeyboardHiding()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


//MARK: EXTENSION: Chat TableView
//********************//

extension BusinessChatVC: UITableViewDelegate, UITableViewDataSource {
    //MARK: Chat TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        if let cell = dequeCell(forMessage: message, for: indexPath) {
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: kBotTextOnlyCellIdentifier, for: indexPath) as! BotTextOnlyCell
        cell.messageTextView.text = "Sorry but I couldn't find what you were looking for."
        
        return cell
    }
    
    func dequeCell(forMessage message: MessageInfo, for indexPath: IndexPath) -> UITableViewCell? {
        switch message.messageType {
            
        case .userTextOnly:
            let message = message as! TextOnlyMessage
            let cell = chatTableView.dequeueReusableCell(withIdentifier: kCurrentUserMessageCellIdentifier, for: indexPath) as! UserTextOnlyCell
            cell.setCellAttributes(withMessage: message)
            return cell
            
        case .userProductQuery:
            print("return userProductQuery cells - this is for SKU barcode scane")
            
        case .botTextOnly:
            print("deque user text only cell")
            
        case .botProductsResponse:
            let message = message as! BotProductsMessage
            let cell = chatTableView.dequeueReusableCell(withIdentifier: kBotProductsResponseCellIdentifier, for: indexPath) as! BotProductsResponseCell
            cell.setCellAttributes(withMessage: message, business: businessInContext)
            return cell
            
        }
        return nil
    }
    
    func scrollToLastMessage() {
        if messages.count > 0 {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
}


//MARK: EXTENSION: MessageToolbar
//********************//

extension BusinessChatVC: MessageToolbarDelegate, UITextViewDelegate {
    
    //MARK: **Keyboard Notifications**
    func setUpKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShowNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                keyboardHeight = keyboardFrame.cgRectValue.height
                keyboardAnimationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
                adjustMessageToolBarPositionWithAnimation(duration: keyboardAnimationDuration, isKeyboardVisible: true)
                adjustTableViewInsetWithKeyboardShowing()
            }
        }
    }
    
    func keyboardWillHideNotification() {
        adjustMessageToolBarPositionWithAnimation(duration: keyboardAnimationDuration, isKeyboardVisible: false)
        adjustTableViewInsetWithKeyboardHiding()
    }
    
    func adjustTableViewInsetWithKeyboardShowing() {
        UIView.animate(withDuration: 0.25, animations: {
            if let keyboardHeight = self.keyboardHeight, let messageToolbar = self.messageToolbar {
                self.chatTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight + messageToolbar.frame.size.height, 0)
                self.chatTableView.scrollIndicatorInsets = self.chatTableView.contentInset
                self.scrollToLastMessage()
            }
        })
    }
    
    func adjustTableViewInsetWithKeyboardHiding() {
        if let messageToolbar = self.messageToolbar {
            chatTableView.contentInset = UIEdgeInsetsMake(0, 0, messageToolbar.frame.size.height, 0)
            self.chatTableView.scrollIndicatorInsets = self.chatTableView.contentInset
        }
    }
    
    //MARK: **UITextViewDelegate**
    func textViewDidChange(_ textView: UITextView) {
        adjustMessageViewHeightWithMessageSize()
    }
    
    //MARK: **MessageToolbar Helpers**
    func setUpmessageToolbar() {
        maxmessageToolBarHeight = self.view.frame.height / 1.5
        let messageToolBarWidth = view.frame.size.width
        let messageToolBarXPosition = view.frame.origin.x
        let messageToolBarYPosition = view.frame.maxY - messageToolBarHeight
        let viewRectSize = CGRect(x: messageToolBarXPosition, y: messageToolBarYPosition, width: messageToolBarWidth, height: messageToolBarHeight)
        messageToolbar = MessageToolbar(frame: viewRectSize)
        if let messageToolbar = messageToolbar {
            messageToolbar.delegate = self
            messageToolbar.messageTextView.delegate = self;
            self.view.addSubview(messageToolbar)
        }
    }
    
    func adjustMessageToolBarPositionWithAnimation(duration: Double, isKeyboardVisible: Bool) {
        let yPosition:CGFloat
        
        guard let keyboardHeight = keyboardHeight, let messageToolbar = messageToolbar else { return }
        
        switch isKeyboardVisible {
        case true:
            yPosition = (view.frame.maxY - keyboardHeight) - (messageToolbar.frame.size.height)
        case false:
            yPosition = self.view.frame.maxY - messageToolbar.frame.size.height
        }
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn], animations: {
            messageToolbar.frame.origin.y = yPosition
            
        }, completion: nil)
    }
    
    func adjustMessageViewHeightWithMessageSize() {
        if let textView = messageToolbar?.messageTextView {
            switch isMaxHeightReached() {
            case false:
                let previousTextViewHeight = textView.frame.size.height
                setNewTextViewFrameSize()
                let currentTextViewHeight = textView.frame.size.height
                if  currentTextViewHeight > previousTextViewHeight {
                    let heightDifference = currentTextViewHeight - previousTextViewHeight
                    adjustmessageToolBarHeight(increaseHeight: true, height: heightDifference)
                } else if currentTextViewHeight < previousTextViewHeight {
                    let heightDifference = previousTextViewHeight - currentTextViewHeight
                    adjustmessageToolBarHeight(increaseHeight: false, height: heightDifference)
                }
            case true:
                let currentContentSizeHeight = textView.contentSize.height
                let currentTextViewHeight = textView.frame.size.height
                if currentContentSizeHeight < currentTextViewHeight {
                    let heightDifference = currentTextViewHeight - currentContentSizeHeight
                    adjustmessageToolBarHeight(increaseHeight: false, height: heightDifference)
                }
            }
        }
    }
    
    func adjustmessageToolBarHeight(increaseHeight: Bool, height: CGFloat) {
        var newmessageToolBarHeight = CGFloat()
        guard let messageToolbar = messageToolbar, let keyboardHeight = keyboardHeight else { return }
        
        if increaseHeight == true {
            newmessageToolBarHeight = messageToolbar.frame.size.height + height
        } else {
            newmessageToolBarHeight = messageToolbar.frame.size.height - height
        }
        messageToolbar.frame.size.height = newmessageToolBarHeight
        let yPosition = (view.frame.maxY - keyboardHeight) - (messageToolbar.frame.size.height)
        messageToolbar.frame.origin.y = yPosition
    }
    
    func isMaxHeightReached() -> Bool {
        if let messageToolbarHeight = messageToolbar?.frame.height, let keyboardHeight = keyboardHeight, let maxHeight = maxmessageToolBarHeight {
            if messageToolbarHeight + keyboardHeight < maxHeight {
                return false
            }
        }
        return true
    }
    
    func setNewTextViewFrameSize() {
        guard let messageToolbar = messageToolbar else { return }
        
        //Get the Text View's Content Size
        let contentSize = messageToolbar.messageTextView.sizeThatFits(messageToolbar.messageTextView.bounds.size)
        
        //Get the text view's current frame (at this point it would have been increased or decreased)
        var newFrame = messageToolbar.messageTextView.frame
        
        //Set the textView's newFrame's Height based on the contentSize's Height
        newFrame.size.height = contentSize.height
        
        //Set the textview's current frame to the newFrame
        messageToolbar.messageTextView.frame = newFrame
    }

    //MARK: **MessageToolbarDelegate**
    func sendMessage() {
        //*used to send messages from toolbar*

        //Process:
        //1. Accept a user a message
        //2. Send user message to Firebase
        //3. Send user message to a "message processor class"
        //4. Message Processor will determine the correct response
        //5. Message Processor returns a message back to the user and sends to Firebase.
        //6. Message is handled appropriately based on the user's message.
        
        
        if let text = messageToolbar?.messageTextView.text {
            let message = TextOnlyMessage(messageType: .userTextOnly, text: text)
            firebaseOperation.save(userMessage: message)
            
            self.messages.append(message)
            self.chatTableView.reloadData()
            
            MessageProcessor().process(message: message, business: businessInContext, botResponse: { (genericMessage, products) in
                print("GENERIC MESSAGE: \(genericMessage)")
                print("PRODUCTS ARRAY: \(products)")
                if let returnedProducts = products {
                    let productMessage = BotProductsMessage(messageType: .botProductsResponse, products: returnedProducts)
                    self.messages.append(productMessage)
                    self.chatTableView.reloadData()
                }
            })
        }
    }

}

