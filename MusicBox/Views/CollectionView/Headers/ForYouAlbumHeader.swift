//
//  File.swift
//  MusicBox
//
//  Created by Ko Kyaw on 05/03/2021.
//

import UIKit
import SnapKit

class ForYouAlbumHeader: UICollectionReusableView {
    
    static let elementKind = "ForYouAlbumHeaderKind"
    
    private lazy var forYouLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "For You"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dividerView)
        addSubview(forYouLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dividerView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        forYouLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
