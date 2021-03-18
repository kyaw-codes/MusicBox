//
//  CommentView.swift
//  MusicBox
//
//  Created by Ko Kyaw on 11/03/2021.
//

import UIKit
import SnapKit

class WriteCommentView: UIView {
    
    var delegate: WriteCommentViewDelegate?
    
    // text view
    private var textPlaceholderView: UIView = {
        let view = UIView()
        view.backgroundColor = .commentBarBackground
        return view
    }()
    
    lazy var commentTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Say smth nice!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.appAccent])
        tf.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        tf.textColor = .appAccent
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.backgroundColor = .clear
        return tf
    }()
    
    // emoji picker image view
    private lazy var emojiPickerImageView: UIImageView = {
        let iconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 26))
        let smileIcon = UIImage(systemName: "face.smiling.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.appAccent)
        let iv = UIImageView(image: smileIcon)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEmojiPickerTap)))
        return iv
    }()
    
    // send button
    private lazy var sendButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 20))
        let planeIcon = UIImage(systemName: "paperplane.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        btn.setImage(planeIcon, for: .normal)
        return btn
    }()
    
    // on send button click
 
    override init(frame: CGRect){
        super.init(frame: frame)
            
        textPlaceholderView.addSubview(commentTextField)
        textPlaceholderView.addSubview(emojiPickerImageView)
        
        addSubview(textPlaceholderView)
        addSubview(sendButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
            
        textPlaceholderView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(sendButton.snp.leading).inset(-10)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(frame.height - 12)
        }
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
        sendButton.clipsToBounds = true
        sendButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSendButtonTap)))
        
        // Add gradient layer
        sendButton.applyGradient(colours: [UIColor.appPurple, UIColor.appRed], locations: [0, 0.5])

        commentTextField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        emojiPickerImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(commentTextField.snp.trailing).inset(-10)
            make.width.equalTo(30)
        }
        
        textPlaceholderView.layer.cornerRadius = textPlaceholderView.frame.height / 2
        textPlaceholderView.clipsToBounds = true
    }
    
    @objc private func handleEmojiPickerTap() {
        delegate?.onEmojiPickerTap()
    }
    
    @objc private func handleSendButtonTap() {
        delegate?.onSendButtonTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
