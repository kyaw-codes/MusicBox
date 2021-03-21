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
            case Section.otherAlbums.rawValue:
                return AlbumDetailVC.createOtherAlbumsSection()
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
    
    private let artistBioCellRegistration = UICollectionView.CellRegistration<ArtistBioCell, AlbumModel> { (cell, indexPath, album) in
        cell.bioText = album.artistBio
    }
    
    private lazy var artistHeaderRegistration = UICollectionView.SupplementaryRegistration<ArtistPhotoHeader>(elementKind: ArtistPhotoHeader.elementKind) { [weak self] (header, _, indexPath) in
        guard let strongSelf = self else { return }
        header.artistImage = strongSelf.album?.artistImage
        header.artistName = strongSelf.album?.artistName
    }
    
    private let otherAlbumCellRegistration = UICollectionView.CellRegistration<AlbumCell, AlbumModel> { (cell, indexPath, model) in
        cell.album = model
    }
    
    private lazy var albumHeaderRegistration = UICollectionView.SupplementaryRegistration<AlbumHeader>(elementKind: AlbumHeader.elementKind) { (header, _, _) in
        // NO ACTION
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    // MARK: - Private Helper Methods
    
    private func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .appBackground
    }
    
    private static func createArtistBioSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        
        // Create header
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.45)), elementKind: ArtistPhotoHeader.elementKind, alignment: .top)
        ]
    
        return section
    }
    
    private static func createOtherAlbumsSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        // Create header
        section.boundarySupplementaryItems = [
            .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: AlbumHeader.elementKind, alignment: .top)
        ]
    
        return section
    }

}

// MARK: - Datasource

extension AlbumDetailVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Section.artistBio.rawValue {
            return 1
        } else if section == Section.otherAlbums.rawValue {
            return otherAlbums?.count ?? 0
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.otherAlbums.rawValue:
            let album = otherAlbums?[indexPath.item]
            return collectionView.dequeueConfiguredReusableCell(using: otherAlbumCellRegistration, for: indexPath, item: album)
        default:
            return collectionView.dequeueConfiguredReusableCell(using: artistBioCellRegistration, for: indexPath, item: album)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case Section.otherAlbums.rawValue:
            return collectionView.dequeueConfiguredReusableSupplementary(using: albumHeaderRegistration, for: indexPath)
        default:
            return collectionView.dequeueConfiguredReusableSupplementary(using: artistHeaderRegistration, for: indexPath)
        }
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
