//
//  HomeVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import SwiftUI
import SnapKit

class HomeVC: UICollectionViewController {
    
    // MARK: - Properties
    
    private var titles: [VideoSliderTitleModel] = [
        .init(title: "Top", isSelected: true),
        .init(title: "Following", isSelected: false),
        .init(title: "Recent", isSelected: false),
        .init(title: "Continue Watching", isSelected: false),
        .init(title: "Suggestion", isSelected: false),
        .init(title: "Favorite", isSelected: false)
    ]
    
    private lazy var sliderVideos: [UIImage] = [
        UIImage(named: "pic_1")!,
        UIImage(named: "pic_2")!,
        UIImage(named: "pic_3")!,
        UIImage(named: "pic_4")!
    ]
    
    private lazy var stories: [StoryModel] = [
        .init(profile: UIImage(named: "pic_3")!, name: "me", isMyStory: true),
        .init(profile: UIImage(named: "pic_4")!, name: "joansilve murad"),
        .init(profile: UIImage(named: "pic_2")!, name: "sarsha"),
    ]
    
    private lazy var albums: [AlbumModel] = [
        .init(coverImage: UIImage(named: "album_1")!, title: "This Title Can Take A Maximum Of Two Lines...", releaseYear: "2021", numberOfTracks: 12, commentCount: 4, likeCount: 27),
        .init(coverImage: UIImage(named: "album_2")!, title: "This Title Is Short", releaseYear: "2021", numberOfTracks: 12, commentCount: 12, likeCount: 20),
    ]

    // MARK: - Cell & Header Registrations
    
    lazy var videoSliderCellRegistration = UICollectionView.CellRegistration<VideoSliderCell, UIImage> { cell, indexPath, video in
        cell.video = video
    }
    
    lazy var videoSliderHeaderRegistration = UICollectionView.SupplementaryRegistration<VideoSliderHeader>(elementKind: VideoSliderHeader.elementKind) { [weak self] (header, _, indexPath) in
        guard let strongSelf = self else { return }
        header.titles = strongSelf.titles
    }
    
    lazy var storyCellRegistration = UICollectionView.CellRegistration<StoryCell, StoryModel> { (cell, indexPath, model) in
        cell.story = model
    }

    lazy var storyHeaderRegistration = UICollectionView.SupplementaryRegistration<StoryHeader>(elementKind: StoryHeader.elementKind) { _, _, _ in
        // DO NOTHING
    }
    
    lazy var albumCellRegistration = UICollectionView.CellRegistration<ForYouAlbumCell, AlbumModel> { (cell, indexPath, model) in
        cell.album = model
    }

    lazy var albumHeaderRegistration = UICollectionView.SupplementaryRegistration<ForYouAlbumHeader>(elementKind: ForYouAlbumHeader.elementKind) { _, _, _ in
        // DO NOTHING
    }
    
    // MARK: Constructors
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 1:
                return HomeVC.createStorySection()
            case 2:
                return HomeVC.createAlbumSection()
            default:
                return HomeVC.createVideoSliderSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        layout.configuration = config
            
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()

        configureNavigationBar()
    }
    
    // MARK: - Private Helper Methods
    
    fileprivate func configureCollectionView() {
        collectionView.backgroundColor = .appBackground
        collectionView.alwaysBounceVertical = true
    }
    
    private func configureNavigationBar() {
        
        guard let navbar = navigationController?.navigationBar else { return }
        navbar.barTintColor = .appBackground
        navbar.isTranslucent = false

        let navView = UIView()
        
        navigationItem.titleView = navView
        
        navView.frame = CGRect(x: 0, y: 0, width: navigationController!.navigationBar.frame.width - 40, height: navigationController!.navigationBar.frame.height)
        
        let homeLabel = UILabel()
        homeLabel.text = "Home"
        homeLabel.font = UIFont.boldSystemFont(ofSize: 34)
        homeLabel.textColor = .white
        
        let iconConfig = UIImage.SymbolConfiguration(font: UIFont.boldSystemFont(ofSize: 22))
        let searchIcon = UIImage(systemName: "magnifyingglass", withConfiguration: iconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(.appAccent)
        let searchButton = UIButton()
        searchButton.setImage(searchIcon, for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [homeLabel, UIView(), searchButton])
        navView.addSubview(stackView)
        stackView.frame = navView.bounds
    }
    
    private static func createVideoSliderSection() -> NSCollectionLayoutSection {
        // Compose cell
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 20
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 20
        section.contentInsets.top = 20
        
        section.orthogonalScrollingBehavior = .groupPaging
        
        // Compose boundary item i.e category header in this case
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: VideoSliderHeader.elementKind, alignment: .top)
        ]

        return section
    }
    
    private static func createStorySection() -> NSCollectionLayoutSection {
        // Compose cell
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 20
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.22), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        // Compose boundary item i.e header in this case
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(48)), elementKind: StoryHeader.elementKind, alignment: .topLeading)
        ]
        
        return section
    }
    
    private static func createAlbumSection() -> NSCollectionLayoutSection {
        // Compose cell
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        // Compose boundary item i.e album header in this case
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: VideoSliderHeader.elementKind, alignment: .top)
        ]

        return section
    }
    
    // MARK: - Override Datasource Methods

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            // Stories section
            return stories.count
        case 2:
            // Albums section
            return albums.count
        default:
            // Return videos
            return sliderVideos.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            // Return story cell
            let story = stories[indexPath.item]
            let storyCell = collectionView.dequeueConfiguredReusableCell(using: storyCellRegistration, for: indexPath, item: story)
            return storyCell
        case 2:
            // Return album cell
            let album = albums[indexPath.item]
            let albumCell = collectionView.dequeueConfiguredReusableCell(using: albumCellRegistration, for: indexPath, item: album)
            return albumCell
        default:
            // Return video slider cell
            let video = sliderVideos[indexPath.item]
            let videoSliderCell = collectionView.dequeueConfiguredReusableCell(using: videoSliderCellRegistration, for: indexPath, item: video)
            return videoSliderCell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 0:
            // Return video slider header
            return collectionView.dequeueConfiguredReusableSupplementary(using: videoSliderHeaderRegistration, for: indexPath)
        case 1:
            // Return story header
            return collectionView.dequeueConfiguredReusableSupplementary(using: storyHeaderRegistration, for: indexPath)
        case 2:
        // Return album header
            return collectionView.dequeueConfiguredReusableSupplementary(using: albumHeaderRegistration, for: indexPath)
        default:
            collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerDefault")
            
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerDefault", for: indexPath)
        }
    }

}

struct HomeVC_Preview: PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return UINavigationController(rootViewController: HomeVC())
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // NO ACTION HERE
        }
    }
}
