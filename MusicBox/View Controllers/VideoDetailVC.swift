//
//  VideoDetailVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 06/03/2021.
//

import SwiftUI
import SnapKit

class VideoDetailVC: UIViewController {
    
    private var comments = CommentModel.comments
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .appBackground
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 16, weight: .semibold))
        let rightArrowIcon = UIImage(systemName: "chevron.backward", withConfiguration: iconConfig)?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.white)
        btn.setImage(rightArrowIcon, for: .normal)
        btn.setTitle("Back", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var writeCommentView: UIView = {
        let commentView = UIView()
        // text field
        // send button
        return commentView
    }()

    private lazy var topVideoView = VideoHeaderView()
    
    private var datasource: UICollectionViewDiffableDataSource<Int, CommentModel>?
    private var snapshot: NSDiffableDataSourceSnapshot<Int, CommentModel>?
    
    private let commentCellRegistration = UICollectionView.CellRegistration<CommentCell, CommentModel> { (cell, indexPath, comment) in
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        createDatasource()
        applySnapshot()
    }
        
    private func setUpViews() {
        view.addSubview(topVideoView)
        topVideoView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 1.8)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topVideoView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
        }
    }
    
    private func createDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let strongSelf = self else { return nil }
            return collectionView.dequeueConfiguredReusableCell(using: strongSelf.commentCellRegistration, for: indexPath, item: item)
        })
    }
    
    private func applySnapshot() {
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot?.appendSections([0])
        snapshot?.appendItems(comments)
        
        datasource?.apply(snapshot!)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: .fixed(10), trailing: .none, bottom: .none) // to be figued out very soon

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            return section
        }
    }
    
    @objc private func handleBackButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
}

struct VideoDetailVC_Preview: PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container : UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return VideoDetailVC()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // NO ACTION
        }
    }
}
