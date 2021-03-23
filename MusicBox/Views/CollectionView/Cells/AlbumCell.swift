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
            
            // Setting download button icon based on data
            let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20))
            let iconName = album.isDownloaded ? "icloud.and.arrow.down.fill" : "square.and.arrow.down"
            
            let downloadIcon = UIImage(systemName: iconName, withConfiguration: iconConfig)?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(album.isDownloaded ? .appAccent : .white)
            
            downloadButton.setImage(downloadIcon, for: .normal)
        }
    }
    
    // MARK: - Views
    
    private lazy var albumCoverImageView: UIImageView = {
        let iv = UIImageView()
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
    
    lazy var bottomSeparatorView: UIView = {
        let bottomSeparatorView = UIView()
        bottomSeparatorView.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return bottomSeparatorView
    }()
    
    lazy var downloadButton: UIButton = {
        let btn = UIButton()
//        btn.backgroundColor = .red
        return btn
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
        // The vertical stack of title + subtitle
        let innerSV = UIStackView(arrangedSubviews: [albumTitleLabel, albumInfoLabel, UIView()])
        innerSV.axis = .vertical
        innerSV.spacing = 10
        
        // Specify width and height for image
        albumCoverImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(frame.height)
        }
        
        // Specify width and height for download button
        downloadButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
        }
        
        // Put button inside stack view so that it will position as I wish
        let btnSV = UIStackView(arrangedSubviews: [downloadButton, UIView()])
        btnSV.axis = .vertical
        
        // This is the final stack view for our layout!
        let outerSV = UIStackView(arrangedSubviews: [albumCoverImageView, innerSV, btnSV])
        outerSV.spacing = 14
        
        addSubview(outerSV)
        
        outerSV.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        setupBottomSeparatorView(innerSV)
    }
    
    private func setupBottomSeparatorView(_ innerSV: UIStackView) {
        addSubview(bottomSeparatorView)
        bottomSeparatorView.snp.makeConstraints { (make) in
            make.leading.equalTo(innerSV)
            make.trailing.equalTo(downloadButton)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
}
