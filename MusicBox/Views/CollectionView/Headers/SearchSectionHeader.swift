//
//  ContinueWatchingHeader.swift
//  MusicBox
//
//  Created by Ko Kyaw on 10/03/2021.
//

import UIKit
import SnapKit

class SearchSectionHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let elementKind = "ContinueWatchingHeaderKind"
    
    var headerName: String? {
        didSet {
            guard let header = headerName else { return }
            headerLabel.text = header
        }
    }
    
    // MARK: - Views
    
    private lazy var headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Continue Watching"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var seeAllButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("All", for: .normal)
        btn.setTitleColor(.appAccent, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return btn
    }()
    
    private lazy var bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return view
    }()
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
        addSubview(seeAllButton)
        addSubview(bottomSeparatorView)
        
        headerLabel.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
        }

        seeAllButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }

        bottomSeparatorView.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
