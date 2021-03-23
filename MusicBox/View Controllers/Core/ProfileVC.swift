//
//  ProfileVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import UIKit
import SnapKit

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

    private let statisticCellRegistration = UICollectionView.CellRegistration<ProfileStatisticCell, String> { (cell, _, _) in
        // NO ACTION
    }

    // MARK: - Constructors
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case Section.profileHeading.rawValue:
                return ProfileVC.createProfileHeadingSection()
            case Section.statisticsCell.rawValue:
                return ProfileVC.createStatisticSection()
            default:
                return nil
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        collectionView.alwaysBounceVertical = false
    }
    
    private func setupViews() {
        // add setting button
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    private static func createProfileHeadingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private static func createStatisticSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}

extension ProfileVC {
    
    // MARK: - Datasource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.statisticsCell.rawValue:
            return collectionView.dequeueConfiguredReusableCell(using: statisticCellRegistration, for: indexPath, item: "statistic")
        default:
            return collectionView.dequeueConfiguredReusableCell(using: headingCellRegistration, for: indexPath, item: "heading")
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

extension ProfileVC {
    
    enum Section: Int {
        case profileHeading
        case statisticsCell
        case featuredAlbums
    }
}
