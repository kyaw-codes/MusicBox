//
//  CategoryCollectionViewCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 27/02/2021.
//

import UIKit
import SnapKit

class VideoSliderCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    // MARK: - DataSource Properties
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, UIImage>?
    private var snapShot: NSDiffableDataSourceSnapshot<Int, UIImage>?
    
    // MARK: - Cell Registrations
    
    private var cellRegistration = UICollectionView.CellRegistration<VideoCell, UIImage> { cell, indexPath, item in
        cell.data = item
    }
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        
        createDatasource()
        applySnapShot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = bounds
    }
    
    // MARK: - Private Helper Functions
    
    private func createDatasource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: item)
        })
    }
    
    private func applySnapShot() {
        snapShot = NSDiffableDataSourceSnapshot()
        snapShot?.appendSections([0])
        snapShot?.appendItems([
            UIImage(named: "pic_1")!, UIImage(named: "pic_2")!, UIImage(named: "pic_3")!, UIImage(named: "pic_4")!,
        ])
        guard let dataSource = dataSource else { return }
        dataSource.apply(snapShot!)
    }
    
    // MARK: - Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
}
