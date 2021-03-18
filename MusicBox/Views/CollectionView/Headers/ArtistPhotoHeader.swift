//
//  ArtistPhotoHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 08/03/2021.
//

import UIKit
import SnapKit

class ArtistPhotoHeader : UICollectionReusableView {
    
    static let elementKind = "ArtistPhotoHeaderKind"
    
    var artistImage: UIImage? {
        didSet {
            guard let image = artistImage else { return }
            artistImageView.image = image
        }
    }
    
    var artistName: String? {
        didSet {
            guard let name = artistName else { return }
            artistNameLabel.text = name
        }
    }
    
    private lazy var artistImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var addFriendButton: UIButton = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        addSubview(artistImageView)

        artistImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        // Add gradient layer
        if artistImageView.layer.sublayers == nil {
            artistImageView.applyGradient(colours: [UIColor.clear, UIColor.appBackground],
                                          locations: [0, 0.6],
                                          frame: CGRect(x: 0, y: frame.maxY - (frame.height * 0.15), width: frame.width, height: frame.height * 0.15))
        }
        
        addSubview(artistNameLabel)
        artistNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        addSubview(addFriendButton)
        addFriendButton.snp.makeConstraints { (make) in
            make.top.equalTo(artistNameLabel).inset(8)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(70)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
