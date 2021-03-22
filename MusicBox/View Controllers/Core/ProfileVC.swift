//
//  ProfileVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
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
        lbl.text = "Experience singer 👩🏻‍🎤, loves oriental drammatic dancing and can't live without playing piano 🎹"
        lbl.textColor = .appAccent
        lbl.font = .systemFont(ofSize: 16)
        lbl.numberOfLines = 2
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
            
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
        
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
            make.leading.equalToSuperview().inset(24)
            make.bottom.equalTo(backgroundImageView)
        }
        
        // Bio text
        addSubview(bioLabel)
        bioLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileLabel)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(profileLabel.snp.bottom).inset(-12)
        }
        
        // edit button
        addSubview(editButton)
        editButton.snp.makeConstraints { (make) in
            make.leading.equalTo(profileLabel)
            make.bottom.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        editButton.layer.cornerRadius = 40 / 2
        editButton.clipsToBounds = true
    }
}

class ProfileVC: UICollectionViewController {
    
    // MARK: - View
    private lazy var settingButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20))
        let settingIcon = UIImage(systemName: "gearshape.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.white.withAlphaComponent(0.8))
        btn.setImage(settingIcon, for: .normal)
        return btn
    }()
    
    // MARK: - Cell Registrations
    private let headingCellRegistration = UICollectionView.CellRegistration<ProfileHeadingCell, String> { (cell, _, _) in
        // NO ACTION
    }

    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        configureCollectionView()
        setupViews()
    }
    
    // MARK: - Private Helpers
    
    private func configureCollectionView() {
        // Make the cell inset to cover the status bar
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        collectionView.contentInset.top = -(window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
        
        collectionView.backgroundColor = .appBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupViews() {
        // add setting button
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
}

extension ProfileVC {
    
    // MARK: - Datasource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: headingCellRegistration, for: indexPath, item: "heading")
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2.2)
    }
}

extension ProfileVC {
    
    enum Section: Int {
        case profileHeading
        case statisticsCell
        case featuredAlbums
    }
}
