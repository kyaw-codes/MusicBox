//
//  VideoSliderCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 02/03/2021.
//

import UIKit
import SnapKit

class VideoSliderCell: UICollectionViewCell {
    
    var video: UIImage? {
        didSet {
            guard let image = video else { return }
            videoImageView.image = image
        }
    }
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(videoImageView)
        addSubview(playButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        playButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
