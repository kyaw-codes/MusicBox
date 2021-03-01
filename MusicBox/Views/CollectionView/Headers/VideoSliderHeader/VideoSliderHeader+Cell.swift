//
//  VideoSliderHeader+Cell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 01/03/2021.
//

import UIKit
import SnapKit

extension VideoSliderHeader {
    
    // MARK: - Cell
    
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
