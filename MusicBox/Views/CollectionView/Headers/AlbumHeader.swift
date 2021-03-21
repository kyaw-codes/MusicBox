//
//  AlbumHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 10/03/2021.
//

import UIKit
import SnapKit

class AlbumHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let elementKind = "AlbumHeaderKind"
    
    // MARK: - Views
    
    private lazy var albumsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Albums"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return view
    }()
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dividerView)
        addSubview(albumsLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dividerView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        albumsLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
