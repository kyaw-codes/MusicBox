//
//  ArtistBioCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 06/03/2021.
//

import UIKit
import SnapKit
import ReadMoreTextView

class ArtistBioCell: UICollectionViewCell {
    
    var bioText: String? {
        didSet {
            guard let bioText = bioText else { return }
            bioTextView.attributedText = NSAttributedString(string: bioText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white])
            dummyTextView.text = bioText
        }
    }

    private lazy var bioTextView: ReadMoreTextView = {
        let textView = ReadMoreTextView()
        textView.shouldTrim = true
        textView.maximumNumberOfLines = 3
        
        textView.attributedReadMoreText = NSAttributedString(string: "Show More", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.appRed])
        
        textView.attributedReadLessText = NSAttributedString(string: "Show Less", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.appAccent])
        
        textView.backgroundColor = .appBackground

        return textView
    }()
    
    private lazy var dummyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dummyTextView)
        dummyTextView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
