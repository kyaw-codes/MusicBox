//
//  AlbumDetailVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 06/03/2021.
//

import SwiftUI
import SnapKit

class AlbumDetailVC: UICollectionViewController {
    
    // MARK: - Properties
    
    var album: AlbumModel?
    var otherAlbums: [AlbumModel]?
    
    // MARK: - Constructors
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            default:
                return AlbumDetailVC.createArtistBioSection()
            }
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell & Header Registrations
    
    private let artistBioCellRegistration = UICollectionView.CellRegistration<ArtistBioCell, String> { (cell, indexPath, bio) in
        cell.bioText = bio
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .appBackground
    }
    
    // MARK: - Private Helper Methods
    
    private static func createArtistBioSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
    
        return section
    }

}

// MARK: - Datasource

extension AlbumDetailVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
//        if section == Section.artistBio.rawValue {
//            return 1
//        } else if section == Section.otherAlbums.rawValue {
//            return otherAlbums?.count ?? 0
//        } else {
//            return 0
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: artistBioCellRegistration, for: indexPath, item: album?.artistBio)
    }
}

// MARK: - Section

extension AlbumDetailVC {
    
    enum Section: Int {
        case artistBio = 0
        case otherAlbums = 1
    }
}

struct AlbumDetailVC_Preview: PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return AlbumDetailVC()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // NO ACTION
        }
    }
    
}
