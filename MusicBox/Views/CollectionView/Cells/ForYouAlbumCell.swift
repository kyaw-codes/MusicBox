//
//  ForYouAlbumCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 04/03/2021.
//

import UIKit
import SnapKit

class ForYouAlbumCell: UICollectionViewCell {
    
    var album: AlbumModel? {
        didSet {
            // Bind with data
            guard let album = album else { return }
            albumImageView.image = album.coverImage
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            let titleAttributedString = NSAttributedString(string: album.title, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle])
            titleLabel.attributedText = titleAttributedString

            commentCountLabel.text = String(album.commentCount)
            likeCountLabel.text = String(album.likeCount)
        }
    }
    
    // Album image view
    private lazy var albumImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    // title label
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = .white
        lbl.numberOfLines = 2
        return lbl
    }()
    
    // comment button
    private lazy var commentButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18))
        let commentIcon = UIImage(systemName: "message.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.appAccent)
        btn.setImage(commentIcon, for: .normal)
        return btn
    }()
    
    // comment count label
    private lazy var commentCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .white
        return lbl
    }()
    
    // like button
    private lazy var likeButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18))
        let heartIcon = UIImage(systemName: "heart.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.appRed)
        btn.setImage(heartIcon, for: .normal)
        return btn
    }()
    

    // like count lable
    private lazy var likeCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .white
        return lbl
    }()
    
    // divider view
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(albumImageView)
        addSubview(titleLabel)
        addSubview(dividerView)
        addSubview(likeCountLabel)
        addSubview(likeButton)
        addSubview(commentCountLabel)
        addSubview(commentButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        albumImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
            make.width.equalTo(frame.width * 0.25)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(albumImageView.snp.trailing).inset(-14)
        }
        
        dividerView.snp.makeConstraints { (make) in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(albumImageView.snp.trailing).inset(-14)
            make.height.equalTo(1)
        }
        
        likeCountLabel.snp.makeConstraints { (make) in
            make.trailing.bottom.equalTo(dividerView).inset(10)
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(likeCountLabel)
            make.trailing.equalTo(likeCountLabel.snp.leading).inset(-4)
        }
        
        commentCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(likeCountLabel)
            make.trailing.equalTo(likeButton.snp.leading).inset(-16)
        }
        
        commentButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(likeCountLabel)
            make.trailing.equalTo(commentCountLabel.snp.leading).inset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
