//
//  SearchVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import SwiftUI

class SearchVC: UICollectionViewController {
    
    // MARK: - Private Properties
    
    private let continueWatchingVideos = WatchedVideoModel.continueWatchingVideos
    private let watchedVideos = WatchedVideoModel.watchedVideos
    private var searchBar: UISearchBar?
    
    // MARK: - Constructors
    init() {
        // Build compositional layout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case Section.CONTINUE_WATCHING.rawValue:
                return SearchVC.createContinueWatchingVideoSection()
            case Section.HISTORY.rawValue:
                return SearchVC.createHistorySection()
            default:
                return SearchVC.createSearchBarSection()
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
    
    // MARK: - Cell & Header Registrations
    
    lazy var searchBarCellRegistration = UICollectionView.CellRegistration<SearchBarCell, Any> { (cell, _, _) in
        self.searchBar = cell.searchBar
    }
    
    let continueWatchingCellRegistration = UICollectionView.CellRegistration<WatchedVideoCell, WatchedVideoModel> { (cell, indexPath, model) in
        cell.video = model
    }
    
    let continueWatchingHeaderRegistration = UICollectionView.SupplementaryRegistration<SearchSectionHeader>(elementKind: SearchSectionHeader.elementKind) { (header, _, indexPath) in
        header.headerName = indexPath.section == Section.CONTINUE_WATCHING.rawValue ? "Continue Watching" : "History"
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap)))
        configureNavigationBar()
        
        collectionView.backgroundColor = .appBackground
    }
    
    // MARK: - Private Helpers
    
    private func configureNavigationBar() {
        title = "Search"
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let navigationBarAppearance = UINavigationBarAppearance()

        navigationBarAppearance.backgroundColor = .appBackground

        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
    }
    
    private static func createSearchBarSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    // Compose continue watching section
    private static func createContinueWatchingVideoSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45)), elementKind: SearchSectionHeader.elementKind, alignment: .top)
        ]
        
        return section
    }
    
    // Compose continue watching section
    private static func createHistorySection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45)), elementKind: SearchSectionHeader.elementKind, alignment: .top)
        ]
        
        return section
    }
    
    // MARK: - Handler
    @objc private func handleViewTap() {
        searchBar?.searchTextField.endEditing(true)
    }
    
}

extension SearchVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Section.CONTINUE_WATCHING.rawValue:
            return continueWatchingVideos.count
        case Section.HISTORY.rawValue:
            return watchedVideos.count
        default:
            return 1
        }
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.CONTINUE_WATCHING.rawValue:
            let model = continueWatchingVideos[indexPath.item]
            return collectionView.dequeueConfiguredReusableCell(using: continueWatchingCellRegistration, for: indexPath, item: model)
        case Section.HISTORY.rawValue:
            let model = watchedVideos[indexPath.item]
            return collectionView.dequeueConfiguredReusableCell(using: continueWatchingCellRegistration, for: indexPath, item: model)
        default:
            return collectionView.dequeueConfiguredReusableCell(using: searchBarCellRegistration, for: indexPath, item: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueConfiguredReusableSupplementary(using: continueWatchingHeaderRegistration, for: indexPath)
    }
}

extension SearchVC {
    
    enum Section: Int {
        case SEARCH_BAR = 0
        case CONTINUE_WATCHING = 1
        case HISTORY = 2
    }
}

struct SearchVC_Preview : PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return SearchVC()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // NO ACTION
        }
    }
}
