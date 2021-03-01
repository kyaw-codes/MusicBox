//
//  HomeVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import SwiftUI
import SnapKit

class HomeVC: UICollectionViewController {
    
    // MARK: - Private Properties
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    var snapShot: NSDiffableDataSourceSnapshot<Int, String>!
    
    // MARK: - Cell & Header Registrations
    let videoSliderCellRegistration = UICollectionView.CellRegistration<VideoSliderCell, String> { cell, indexPath, item in
        // Populate the cell with provided data(item)
    }
    
    let videoSliderHeaderRegistration = UICollectionView.SupplementaryRegistration<VideoSliderHeader>(elementKind: UICollectionView.elementKindSectionHeader) { view, indexPath, item in
        // Populate the header with provided data(item)
    }
    
    // MARK: Constructors
    
    init() {
        let layout = HomeVC.createCompositionalLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .appBackground
        collectionView.alwaysBounceVertical = true

        configureNavigationBar()
        
        createDatasource()
        applySnapshot()

    }
    
    // MARK: - Private Helper Methods
    
    /*
     * Configure the navigation bar appearance
     */
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
    
    private func createDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let strongSelf = self else { return nil }
            
            switch indexPath.section {
            case 1:
                return nil
            default:
                let cell = collectionView.dequeueConfiguredReusableCell(using: strongSelf.videoSliderCellRegistration, for: indexPath, item: item)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let strongSelf = self else { return nil }
            
            switch indexPath.section {
            default:
                let header = collectionView.dequeueConfiguredReusableSupplementary(using: strongSelf.videoSliderHeaderRegistration, for: indexPath)
                
                return header
            }
            
        }
    }
    
    private func applySnapshot() {
        snapShot = NSDiffableDataSourceSnapshot<Int, String>()
        snapShot.appendSections([0])
        snapShot.appendItems(["Top"], toSection: 0)
        
        dataSource.apply(snapShot)
    }
    
    private static func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            default:
                return HomeVC.createVideosSliderSection()
            }
        }
        
        layout.configuration.interSectionSpacing = 20
        
        return layout
    }
    
    private static func createVideosSliderSection() -> NSCollectionLayoutSection {
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(56)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        
        // The amount of space between the content of the section and its boundaries.
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 0, trailing: 0)
        return section
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
