//
//  ProfileVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import UIKit
import SnapKit

class ProfileVC: UICollectionViewController {
    
    // MARK: - Properties
    private var featuredAlbums: [AlbumModel] = [
        AlbumModel(coverImage: UIImage(named: "vid_1")!, artistImage: UIImage(), title: "Make Me Happy", artistName: "", artistBio: "", releaseYear: "2021", numberOfTracks: 4, commentCount: 0, likeCount: 0),
        AlbumModel(coverImage: UIImage(named: "vid_2")!, artistImage: UIImage(), title: "Rock back to school", artistName: "", artistBio: "", releaseYear: "2018", numberOfTracks: 8, commentCount: 0, likeCount: 0),
        AlbumModel(coverImage:UIImage(named: "vid_3")!, artistImage: UIImage(), title: "Up(Single)", artistName: "", artistBio: "", releaseYear: "2021", numberOfTracks: 11, commentCount: 0, likeCount: 0, isDownloaded: true),
        AlbumModel(coverImage:  UIImage(named: "vid_4")!, artistImage: UIImage(), title: "Love you, hate you", artistName: "", artistBio: "", releaseYear: "2018", numberOfTracks: 10, commentCount: 0, likeCount: 0, isDownloaded: true),
        AlbumModel(coverImage: UIImage(named: "vid_5")!, artistImage: UIImage(), title: "Paradise", artistName: "", artistBio: "", releaseYear: "2020", numberOfTracks: 6, commentCount: 0, likeCount: 0),
        AlbumModel(coverImage: UIImage(named: "vid_6")!, artistImage: UIImage(), title: "Double Blood", artistName: "", artistBio: "", releaseYear: "2019", numberOfTracks: 2, commentCount: 0, likeCount: 0, isDownloaded: true),
        AlbumModel(coverImage: UIImage(named: "vid_7")!, artistImage: UIImage(), title: "Swingg", artistName: "", artistBio: "", releaseYear: "2018", numberOfTracks: 4, commentCount: 0, likeCount: 0),
        AlbumModel(coverImage: UIImage(named: "album_3")!, artistImage: UIImage(), title: "La-la-la", artistName: "", artistBio: "", releaseYear: "2018", numberOfTracks: 7, commentCount: 0, likeCount: 0),
    ]
    
    // MARK: - View
    private lazy var settingButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20))
        let settingIcon = UIImage(systemName: "gearshape.fill", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.white.withAlphaComponent(0.8))
        btn.setImage(settingIcon, for: .normal)
        return btn
    }()
    
    // MARK: - Cell & Header Registrations
    private let headingCellRegistration = UICollectionView.CellRegistration<ProfileHeadingCell, String> { (cell, _, _) in
        // NO ACTION
    }

    private let statisticCellRegistration = UICollectionView.CellRegistration<ProfileStatisticCell, String> { (cell, _, _) in
        // NO ACTION
    }
    
    private let featuredAlbumCellRegistration = UICollectionView.CellRegistration<AlbumCell, AlbumModel> { (cell, _, item) in
        cell.album = item
    }
    
    private let albumHeaderRegistration = UICollectionView.SupplementaryRegistration<AlbumHeader>(elementKind: AlbumHeader.elementKind) { (header, _, _) in
        // I'm supposed to add some padding to the leading but it'll take some times to fix some constraints so I'm cheating on it with five spaces. You don't wanna do like this for your real-world project ✌🏻.
        header.albumsLabel.text = "     Featured Albums"
        header.dividerView.isHidden = true
    }

    // MARK: - Constructors
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case Section.profileHeading.rawValue:
                return ProfileVC.createProfileHeadingSection()
            case Section.statisticsCell.rawValue:
                return ProfileVC.createStatisticSection()
            case Section.featuredAlbums.rawValue:
                return ProfileVC.createFeaturedAlbumSection()
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
}

extension ProfileVC {
    
    // MARK: - Sections
    
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
    
    private static func createFeaturedAlbumSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: AlbumHeader.elementKind, alignment: .top)
        ]
        
        return section
    }
}

extension ProfileVC {
    
    // MARK: - Datasource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.statisticsCell.rawValue:
            return collectionView.dequeueConfiguredReusableCell(using: statisticCellRegistration, for: indexPath, item: "statistic")
        case Section.featuredAlbums.rawValue:
            let album = featuredAlbums[indexPath.item]
            return collectionView.dequeueConfiguredReusableCell(using: featuredAlbumCellRegistration, for: indexPath, item: album)
        default:
            return collectionView.dequeueConfiguredReusableCell(using: headingCellRegistration, for: indexPath, item: "heading")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == Section.featuredAlbums.rawValue {
            return collectionView.dequeueConfiguredReusableSupplementary(using: albumHeaderRegistration, for: indexPath)
        }
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Section.featuredAlbums.rawValue {
            return featuredAlbums.count
        }
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
