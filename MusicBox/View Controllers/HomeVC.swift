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
    
    private lazy var sliderVideos: [UIImage] = [#imageLiteral(resourceName: "pic_1"), #imageLiteral(resourceName: "pic_2"), #imageLiteral(resourceName: "pic_4"), #imageLiteral(resourceName: "pic_6")]
    
    // MARK: - Cell & Header Registrations
    
    let videoSliderCellRegistration = UICollectionView.CellRegistration<VideoSliderCell, UIImage> { cell, indexPath, video in
        cell.video = video
    }

    // MARK: Constructors
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            switch sectionIndex {
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
        
        // Compose boundary item i.e header in this case

        return section
    }
    
    // MARK: - Override Datasource Methods

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        default:
            // Return videos
            return sliderVideos.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        default:
            // Return video slider cell
            let video = sliderVideos[indexPath.item]
            let videoSliderCell = collectionView.dequeueConfiguredReusableCell(using: videoSliderCellRegistration, for: indexPath, item: video)
            return videoSliderCell
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
