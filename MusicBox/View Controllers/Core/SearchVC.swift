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
    
    // MARK: - Constructors
    init() {
        // Build compositional layout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            return SearchVC.createSearchBarSection()
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
    
    // Register search cell
    let searchBarCellRegistration = UICollectionView.CellRegistration<SearchBarCell, Any> { (_, _, _) in
        // DO NOTHING
    }
    
    // TODO: Register continue watching cell
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        collectionView.backgroundColor = .appBackground
    }
    
    // MARK: - Private Helpers
    
    private static func createSearchBarSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    // TODO: Compose continue watching section

}

extension SearchVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: searchBarCellRegistration, for: indexPath, item: nil)
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
