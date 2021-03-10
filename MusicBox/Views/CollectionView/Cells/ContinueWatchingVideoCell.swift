//
//  ContinueWatchingVideoCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 10/03/2021.
//

import UIKit

class ContinueWatchingVideoCell: UICollectionViewCell {
    
    var video: WatchedVideoModel? {
        didSet {
            guard let video = video else { return }
            imageView.image = video.coverImage
            titleLabel.text = video.title
            viewerLabel.text = "\(video.viewerCounts) Views"
        }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var viewerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .appAccent
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        let sv = UIStackView(arrangedSubviews: [imageView, titleLabel, viewerLabel])
        sv.axis = .vertical
        sv.spacing = 6
        sv.setCustomSpacing(10, after: titleLabel)
        
        addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
