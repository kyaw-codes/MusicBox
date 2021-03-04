//
//  VideoSliderHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 02/03/2021.
//

import UIKit
import SnapKit

class VideoSliderHeader: UICollectionReusableView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    var titles = [VideoSliderTitleModel]()
    
    static let elementKind = "StoryCellKind"
    
    // MARK: - Cell Registration
    
    private lazy var headerCellRegistration = UICollectionView.CellRegistration<HeaderCell, VideoSliderTitleModel> { (cell, indexPath, item) in
        cell.title = item
        
        cell.onTap = { selectedTitle in
            // Reset the title selection state
            self.titles.forEach { (title) in
                title.isSelected = title.title == selectedTitle.title
            }
            
            // Reload the data
            self.collectionView.reloadData()
        }
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return view
    }()
    
    // MARK: - Constructors & Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(dividerView)
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dividerView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(1.5)
            make.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Datasource & Delegate Methods
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
}

extension VideoSliderHeader {

    // MARK: - Header Cell
    
    class HeaderCell: UICollectionViewCell {
        
        // MARK: - Properties
        
        var onTap: (VideoSliderTitleModel) -> Void = {_ in}
        
        var title: VideoSliderTitleModel? {
            didSet {
                guard let model = title else { return }
                titleLabel.text = model.title
                titleLabel.textColor = model.isSelected ? .white : .appAccent
                bottomUnderlineView.isHidden = !model.isSelected
            }
        }
        
        // MARK: - Views
        
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
        
        // MARK: - Constructors & Lifecycles
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(titleLabel)
            addSubview(bottomUnderlineView)
            
            contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
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

        // MARK: - Handler Methods
        
        @objc func handleTap() {
            onTap(title!)
        }
        
    }
}
