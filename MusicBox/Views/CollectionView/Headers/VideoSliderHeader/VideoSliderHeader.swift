//
//  VideoSliderHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 28/02/2021.
//

import UIKit

class VideoSliderHeader: UICollectionReusableView {
    
    // MARK: - Shared Properties
    
    var sliderTitles: [VideoSliderTitleModel] = [
        .init(title: "Top", isSelected: true),
        .init(title: "Following", isSelected: false),
        .init(title: "Continue Watching", isSelected: false),
        .init(title: "Recent", isSelected: false),
        .init(title: "Favourite", isSelected: false),
        .init(title: "Suggestion", isSelected: false)
    ]
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        return view
    }()
    
    // MARK: - Cell Registrations
    
    private lazy var cellRegistration = UICollectionView.CellRegistration<HeaderCell, VideoSliderTitleModel> { [weak self] cell, indexPath, model in
        guard let strongSelf = self else { return }
        cell.data = model
        
        cell.onTap = { [weak self] selectedTitle in
            guard let strongSelf = self else { return }
            strongSelf.changeTitleSelectionState(to: selectedTitle)
            strongSelf.applySnapshot()
            strongSelf.collectionView.reloadData()
        }
    }
    
    // MARK: - Private Properties(Datasource & Snapshot)
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, VideoSliderTitleModel>?
    private var snapShot: NSDiffableDataSourceSnapshot<Int, VideoSliderTitleModel>?
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dividerView)
        
        addSubview(collectionView)
        collectionView.delegate = self
        
        createDatasource()
        applySnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dividerView.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(1)
        }

        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    // MARK: - Private Helpers
    
    private func createDatasource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let strongSelf = self else { return nil }
            return collectionView.dequeueConfiguredReusableCell(using: strongSelf.cellRegistration, for: indexPath, item: item)
        })
    }
    
    private func applySnapshot() {
        guard let dataSource = dataSource else { return }
        snapShot = NSDiffableDataSourceSnapshot()
        snapShot?.appendSections([1])
        snapShot?.appendItems(sliderTitles)
        dataSource.apply(snapShot!)
    }
    
    /*
     * Update the isSelected state of current snpashot.
     */
    private func changeTitleSelectionState(to selectedTitle: VideoSliderTitleModel) {
        sliderTitles.forEach { (titleModel) in
            if titleModel.title == selectedTitle.title {
                titleModel.isSelected = true
            } else {
                titleModel.isSelected = false
            }
        }
    }

}
