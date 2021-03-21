//
//  NotificationCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 21/03/2021.
//

import UIKit
import SnapKit

class NotificationCell : UICollectionViewCell {
    
    // MARK: - Properties
    var notification: NotificationModel? {
        didSet {
            guard let notification = notification else { return }
            
            profileImageView.image = notification.profileImage
            
            let attrString = NSMutableAttributedString(string: "\(notification.name) ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
            attrString.append(NSAttributedString(string: (notification.type.humanReadableText)))
            
            notificationTextLable.attributedText = attrString
            
            timeLabel.text = notification.time
            
            setupViews()
        }
    }
    
    // MARK: - Views
    
    // profileImageView
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // optional like badge
    private lazy var likeBadgeView: UIView = {
        let view = UIView()
        
        let iconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 16))
        let heartIcon = UIImage(systemName: "suit.heart.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let iv = UIImageView(image: heartIcon)
        
        view.addSubview(iv)
        iv.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }
        
        view.layer.cornerRadius = 30 / 2
        view.clipsToBounds = true
        return view
    }()
    
    // optional comment badge
    private lazy var commentBadgeView: UIView = {
        let view = UIView()
        
        let iconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 16))
        let messageIcon = UIImage(systemName: "message.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let iv = UIImageView(image: messageIcon)
        
        view.addSubview(iv)
        iv.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }
        
        view.layer.cornerRadius = 30 / 2
        view.clipsToBounds = true
        return view
    }()
    
    // notification label
    private lazy var notificationTextLable: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // time label
    private lazy var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .appAccent
        return lbl
    }()
    
    // optional follow back button
    private lazy var followBackButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 24))
        let personPlusIcon = UIImage(systemName: "person.fill.badge.plus", withConfiguration: iconConfig)?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.white)
        btn.setImage(personPlusIcon, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        return btn
    }()
    
    private lazy var bottomSeparatorView: UIView = {
        let bottomSeparatorView = UIView()
        bottomSeparatorView.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return bottomSeparatorView
    }()
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add gradient layer
        [likeBadgeView, commentBadgeView].forEach { $0.applyGradient(colours: [UIColor.appPurple, .appRed], locations: [0, 0.5]) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Helpers
    
    private func setupViews() {
        setupProfileImageView()
        setupNotificationLabel()
        setupTimeText()
        setupBottomSeparator()
    }
    
    private func setupProfileImageView() {
        let imageHeight = frame.height - 18
        addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(imageHeight)
            make.top.leading.equalToSuperview()
        }
        profileImageView.layer.cornerRadius = imageHeight / 2
        
        if notification?.type == NotificationModel.NotificationType.like || notification?.type == NotificationModel.NotificationType.reply {
            setupOptionalBadge(type: notification!.type)
        }
    }
    
    private func setupNotificationLabel() {
        addSubview(notificationTextLable)
        
        notificationTextLable.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            
            if notification!.type == .follow {
                // Show follow back button if and only if the notification type is 'follow'
                setupFollowBackButton()
                make.trailing.equalTo(followBackButton.snp.leading)
            } else {
                make.trailing.equalToSuperview()
            }
            
            make.leading.equalTo(profileImageView.snp.trailing).inset(-16)
        }
    }
    
    private func setupOptionalBadge(type: NotificationModel.NotificationType) {
        let badgeView = type == .like ? likeBadgeView : commentBadgeView
        addSubview(badgeView)
        badgeView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.bottom.equalTo(profileImageView).inset(-5)
            make.centerX.equalTo(profileImageView.snp.trailing).inset(12)
        }
    }
    
    private func setupFollowBackButton() {
        addSubview(followBackButton)
        followBackButton.snp.makeConstraints { (make) in
            make.width.equalTo(64)
            make.height.equalTo(36)
            make.top.equalTo(notificationTextLable)
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupTimeText() {
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(notificationTextLable)
            make.top.equalTo(notificationTextLable.snp.bottom).inset(-8)
        }
    }
    
    private func setupBottomSeparator() {
        addSubview(bottomSeparatorView)
        bottomSeparatorView.snp.makeConstraints { (make) in
            make.leading.equalTo(notificationTextLable)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
}
