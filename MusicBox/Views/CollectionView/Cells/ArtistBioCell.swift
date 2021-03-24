//
//  ArtistBioCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 06/03/2021.
//

import UIKit
import SnapKit

class ArtistBioCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var bioText: String? {
        didSet {
            bioTextView.text = bioText
        }
    }

    // MARK: - Views
    
    private lazy var bioTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bioTextView)
        bioTextView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(12)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
