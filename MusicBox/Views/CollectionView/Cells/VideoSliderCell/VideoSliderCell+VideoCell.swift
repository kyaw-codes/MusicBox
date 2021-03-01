//
//  VideoSliderCell+Cell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 01/03/2021.
//

import UIKit
import SnapKit

extension VideoSliderCell {
    
    // MARK: - ViewCell Class
    
    class VideoCell: UICollectionViewCell {
        
        // MARK: - Public Properties
        
        var data: UIImage? {
            didSet {
                guard let image = data else { return }
                videoImageView.image = image
            }
        }
        
        // MARK: - Views
        
        private lazy var videoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            return imageView
        }()
        
        private lazy var playButton: UIButton = {
            let button = UIButton()
            let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 48))
            let playIcon = UIImage(systemName: "play.circle.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.appAccent.withAlphaComponent(0.8))
            button.setImage(playIcon, for: .normal)
            return button
        }()
        
        // MARK: - Constructors
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(videoImageView)
            addSubview(playButton)
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        // MARK: - Lifecycles
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            videoImageView.frame = bounds
            
            playButton.snp.makeConstraints { (make) in
                make.width.height.equalTo(48)
                make.centerX.centerY.equalToSuperview()
            }
        }
        
    }
}
