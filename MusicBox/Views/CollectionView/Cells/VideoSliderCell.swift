//
//  VideoSliderCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 02/03/2021.
//

import UIKit
import SnapKit

class VideoSliderCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var onVideoTap: () -> Void = {}
    
    var video: UIImage? {
        didSet {
            guard let image = video else { return }
            videoImageView.image = image
        }
    }
    
    // MARK: - Views
    
    private lazy var videoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 48))
        let playIcon = UIImage(systemName: "play.circle.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.appAccent.withAlphaComponent(0.8))
        button.setImage(playIcon, for: .normal)
        return button
    }()
    
    // MARK: - Constructors & Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()

        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleVideoTap)))
    }
    
    // MARK: - Private Helpers
    
    private func setupViews() {
        addSubview(videoImageView)
        videoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
    }
    
    // MARK: - Target-Action Handlers
    
    @objc private func handleVideoTap() {
        onVideoTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
