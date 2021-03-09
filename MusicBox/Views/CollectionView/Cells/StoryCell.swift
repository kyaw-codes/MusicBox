//
//  StoryCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 01/03/2021.
//

import UIKit
import SnapKit

class StoryCell: UICollectionViewCell {
    
    var story: StoryModel? {
        didSet {
            guard let story = story else { return }
            profileImageView.image = story.profile
            profileImageView.layer.borderWidth = story.isMyStory ? 0 : 2.5
            
            nameLabel.text = story.name
            
            if story.isMyStory == true {
                
                let attributes = [
                    NSAttributedString.Key.foregroundColor : UIColor.white,
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .semibold)
                ]
                
                let attrString = NSMutableAttributedString(string: "ADD", attributes: attributes)
                
                nameLabel.attributedText = attrString
                nameLabel.backgroundColor = .appGray
            } else {
                nameLabel.text = story.name
            }
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderColor = UIColor.appRed.cgColor
        iv.contentMode = .scaleAspectFill
        iv.snp.makeConstraints { (make) in
            make.width.height.equalTo(frame.width * 0.95)
        }
        iv.layer.cornerRadius = (frame.width * 0.95) / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lbl.textColor = .appAccent
        lbl.backgroundColor = .clear
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 4
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(profileImageView)
            make.bottom.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).inset(-4)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        story?.isMyStory = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
