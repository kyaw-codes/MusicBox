//
//  VideoSliderHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 28/02/2021.
//

import UIKit

class VideoSliderHeader: UICollectionReusableView, UICollectionViewDelegateFlowLayout {
    
    private var sliderTitles: [VideoSliderTitleModel] = [
        .init(title: "Top", isSelected: true),
        .init(title: "Following", isSelected: false),
        .init(title: "Continue Watching", isSelected: false),
        .init(title: "Recent", isSelected: false),
        .init(title: "Favourite", isSelected: false),
        .init(title: "Suggestion", isSelected: false)
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var cellRegistration = UICollectionView.CellRegistration<HeaderCell, VideoSliderTitleModel> { [weak self] cell, indexPath, item in
        guard let strongSelf = self else { return }
        cell.data = strongSelf.sliderTitles[indexPath.item]
        
        cell.onTap = { [weak self] model in
            guard let strongSelf = self else { return }
            strongSelf.sliderTitles.forEach { (titleModel) in
                if titleModel.title == model.title {
                    titleModel.isSelected = true
                } else {
                    titleModel.isSelected = false
                }
            }
            strongSelf.applySnapshot()
            strongSelf.collectionView.reloadData()
        }
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, VideoSliderTitleModel>?
    private var snapShot: NSDiffableDataSourceSnapshot<Int, VideoSliderTitleModel>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.delegate = self
        
        createDatasource()
        applySnapshot()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
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
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = sliderTitles[indexPath.item].title
        let textWidth = String(title).size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width
        return CGSize(width: textWidth + 10, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
    
}

extension VideoSliderHeader {
    
    class HeaderCell: UICollectionViewCell {
        
        var onTap: ((VideoSliderTitleModel) -> Void) = {_ in}
        
        var data: VideoSliderTitleModel? {
            didSet {
                guard let data = data else { return }
                title.text = data.title
                title.textColor = data.isSelected ? .white : .appAccent
                bottomUnderlineView.isHidden = !data.isSelected
            }
        }
        
        private lazy var title: UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            lbl.textColor = .white
            lbl.textAlignment = .center
            return lbl
        }()
        
        private lazy var bottomUnderlineView: UIView = {
            let view = UIView()
            view.backgroundColor = .appRed
            view.layer.cornerRadius = 4 / 2
            view.clipsToBounds = true
            return view
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(title)
            addSubview(bottomUnderlineView)
            
            contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapEvent)))
        }
        
        @objc func handleTapEvent() {
            onTap(data!)
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            title.snp.makeConstraints { (make) in
                make.top.leading.trailing.equalToSuperview()
            }
            
            bottomUnderlineView.snp.makeConstraints { (make) in
                make.leading.bottom.trailing.equalToSuperview()
                make.height.equalTo(4)
            }
        }

    }
}
