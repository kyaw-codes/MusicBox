//
//  OtherAlbumCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 09/03/2021.
//

import UIKit
import SnapKit

class AlbumCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var album: AlbumModel? {
        didSet {
            guard let album = album else { return }
            albumCoverImageView.image = album.coverImage
            albumTitleLabel.text = album.title
            albumInfoLabel.text = "\(album.releaseYear) - \(album.numberOfTracks) Tracks"
        }
    }
    
    // MARK: - Views
    
    private lazy var albumCoverImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width / 4, height: frame.width / 4))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var albumTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return lbl
    }()
    
    private lazy var albumInfoLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .appAccent
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private Helpers
    
    private func setupViews() {
        let innerSV = UIStackView(arrangedSubviews: [albumTitleLabel, albumInfoLabel, UIView()])
        innerSV.axis = .vertical
        innerSV.spacing = 10
        
        albumCoverImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        
        let outerSV = UIStackView(arrangedSubviews: [albumCoverImageView, innerSV])
        outerSV.spacing = 14
        
        addSubview(outerSV)
        
        outerSV.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}
