//
//  StoryHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 04/03/2021.
//

import UIKit
import SwiftUI

class StoryHeader: UICollectionReusableView {
    
    static let elementKind = "StoryHeaderKind"
    
    private lazy var titleLable: UILabel = {
        let lbl = UILabel()
        lbl.text = "All Stories"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lbl.textColor = .appAccent
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLable.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
