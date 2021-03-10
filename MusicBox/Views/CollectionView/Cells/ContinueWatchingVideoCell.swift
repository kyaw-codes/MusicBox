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
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
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
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        lbl.textColor = .appAccent
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(viewerLabel)

        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(frame.width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).inset(-18)
            make.leading.trailing.equalTo(imageView)
        }

        viewerLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(imageView)
            make.top.equalTo(titleLabel.snp.bottom).inset(-8)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
