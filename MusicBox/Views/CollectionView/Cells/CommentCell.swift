//
//  CommentCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 11/03/2021.
//

import UIKit
import SnapKit

class CommentCell: UICollectionViewCell {
    
    var onCommentReacted: ((CommentCell) -> Void)!
    
    var comment: CommentModel? {
        didSet {
            guard let comment = comment else { return }
            profileImageView.image = comment.profileImage
            usernameLabel.text = comment.name
            commentDurationLabel.text = comment.commentDuration
            commentTextLabel.text = comment.comment
            likeButton.tintColor = comment.isReacted ? .appRed : .appAccent
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
        }
        iv.layer.cornerRadius = 40 / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var commentDurationLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .appAccent
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var commentTextLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var likeButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18))
        let heartIcon = UIImage(systemName: "heart.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysTemplate)
        btn.setImage(heartIcon, for: .normal)
        return btn
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        addSubview(likeButton)
        addSubview(usernameLabel)
        addSubview(commentDurationLabel)
        addSubview(commentTextLabel)
        addSubview(dividerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        likeButton.addTarget(self, action: #selector(handleCommentReaction), for: .touchUpInside)

        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.top)
            make.trailing.equalToSuperview()
            make.width.equalTo(22)
            make.height.equalTo(20)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView).inset(2)
            make.leading.equalTo(profileImageView.snp.trailing).inset(-16)
            make.trailing.equalTo(likeButton.snp.leading).inset(-16)
        }
        
        commentDurationLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(usernameLabel)
            make.top.equalTo(usernameLabel.snp.bottom)
        }
        
        commentTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(commentDurationLabel.snp.bottom).inset(-10)
            make.leading.trailing.equalTo(usernameLabel)
        }
        
        dividerView.snp.makeConstraints { (make) in
            make.top.equalTo(commentTextLabel.snp.bottom).inset(-18)
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(usernameLabel.snp.leading)
            make.height.equalTo(1)
        }
    }
    
    override func prepareForReuse() {
        comment?.isReacted = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func handleCommentReaction() {
        onCommentReacted(self)
    }
}
