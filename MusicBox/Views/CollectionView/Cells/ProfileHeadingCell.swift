//
//  ProfileHeadingCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 22/03/2021.
//

import UIKit
import SnapKit

class ProfileHeadingCell: UICollectionViewCell {
    
    var editButtonGradient: CAGradientLayer?
    
    // MARK: - Views
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cv")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var profileLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Monica Linn"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 36, weight: .semibold)
        return lbl
    }()
    
    private lazy var bioLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Experience singer, loves oriental drammatic dancing and can't live without playing piano 🎹"
        lbl.textColor = .appAccent
        lbl.font = .systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 18))
        let icon = UIImage(systemName: "pencil.circle", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        button.setImage(icon, for: .normal)
        button.setTitle(" Edit Profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        editButtonGradient = button.applyGradient(colours: [.appPurple, .appRed], locations: [0, 0.5])
        editButtonGradient?.startPoint = CGPoint(x: 0, y: 0)
        editButtonGradient?.endPoint = CGPoint(x: 1, y: 0)
        button.bringSubviewToFront(button.imageView!)
        return button
    }()
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        if backgroundImageView.layer.sublayers == nil {
            applyGradientToBackgroundImage()
        }
        
        editButtonGradient?.frame = editButton.bounds
    }
    
    
    // MARK: - Private Helpers
    
    private func applyGradientToBackgroundImage() {
        // add gradient
        let gradientHeight = backgroundImageView.frame.height * 0.3
        backgroundImageView.applyGradient(colours: [UIColor.clear, UIColor.appBackground], locations: [0, 0.8], frame: CGRect(x: 0, y: backgroundImageView.frame.height - gradientHeight, width: backgroundImageView.frame.width, height: gradientHeight))
    }

    private func setupViews() {
        // Background Image
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.frame.height / 1.4)
        }
        
        // Profile label
        addSubview(profileLabel)
        profileLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(backgroundImageView)
        }
        
        // Bio text
        addSubview(bioLabel)

        bioLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(profileLabel.snp.bottom).inset(-4)
        }
        
        // edit button
        addSubview(editButton)

        editButton.snp.makeConstraints { (make) in
            make.leading.equalTo(bioLabel.snp.leading)
            make.top.greaterThanOrEqualTo(bioLabel.snp.bottom).inset(-16)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        editButton.layer.cornerRadius = 40 / 2
        editButton.clipsToBounds = true
    }

}
