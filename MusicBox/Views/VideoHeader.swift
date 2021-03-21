//
//  VideoHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 10/03/2021.
//

import UIKit
import SnapKit

class VideoHeaderView: UIView {
    
    // MARK: - Views
    
    private lazy var backgroundImageView: UIImageView = {
        let bgIV = UIImageView(image: UIImage(named: "pic_1"))
        bgIV.contentMode = .scaleAspectFill
        bgIV.clipsToBounds = true
        return bgIV
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton()
        let playIconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 48))
        let playIcon = UIImage(systemName: "play.circle.fill", withConfiguration: playIconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.appAccent.withAlphaComponent(0.8))
        playButton.setImage(playIcon, for: .normal)
        return playButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = "Midnight Theme Is \nBeautiful"
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.font = UIFont.systemFont(ofSize: 16)
        commentLabel.textColor = .systemGray

        let attrString = NSMutableAttributedString(string: "Comments  ")
        attrString.append(NSMutableAttributedString(string: "4", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]))

        commentLabel.attributedText = attrString
        return commentLabel
    }()
    
    private lazy var bottomSeparatorView: UIView = {
        let bottomSeparatorView = UIView()
        bottomSeparatorView.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return bottomSeparatorView
    }()
    
    // MARK: - Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundImageView)
        addSubview(playButton)
        addSubview(titleLabel)
        addSubview(commentLabel)
        addSubview(bottomSeparatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        if backgroundImageView.layer.sublayers == nil {
            // Add gradient layer only when there's no sub layer
            addGradientLayer()
        }
        
        playButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        
        bottomSeparatorView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    private func addGradientLayer() {
        let gradientHeight: CGFloat = frame.height / 2.4
        let gradientLayerOffsetY: CGFloat = frame.height - gradientHeight
        backgroundImageView.applyGradient(colours: [UIColor.clear, UIColor.appBackground], locations: [0, 0.85], frame: CGRect(x: 0, y: gradientLayerOffsetY, width: frame.width, height: gradientHeight))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
