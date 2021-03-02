//
//  VideoSliderHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 02/03/2021.
//

import UIKit
import SnapKit

class HeaderCell: UICollectionViewCell {
    
    var onTap: (VideoSliderTitleModel) -> Void = {_ in}
    
    var title: VideoSliderTitleModel? {
        didSet {
            guard let model = title else { return }
            titleLabel.text = model.title
            titleLabel.textColor = model.isSelected ? .white : .appAccent
            bottomUnderlineView.isHidden = !model.isSelected
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
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
        
        addSubview(titleLabel)
        addSubview(bottomUnderlineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
        
        bottomUnderlineView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class VideoSliderHeader: UICollectionReusableView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var titles = [VideoSliderTitleModel]()
    
    static let kind = "StoryCellKind"
    
    var headerCellRegistration = UICollectionView.CellRegistration<HeaderCell, VideoSliderTitleModel> { (cell, indexPath, item) in
        cell.title = item
    }

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: titles[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let titleText = titles[indexPath.item].title
        let textWidth = titleText.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .semibold)]).width
        return CGSize(width: textWidth + 10, height: collectionView.frame.height)
    }
}
