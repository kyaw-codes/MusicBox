//
//  ProfileStatisticCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 22/03/2021.
//

import UIKit
import SnapKit

class ProfileStatisticCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private lazy var horizontalDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        return view
    }()
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private Helpers
    
    private func setupViews() {
        let reputationStat = buildStatsCol(title: "8/10", subtitle: "Reputation")
        let followerStat = buildStatsCol(title: "1,943", subtitle: "Followers")
        let albumStat = buildStatsCol(title: "4", subtitle: "Albums")
        
        let statisticRow = buildStatsRow(statViews: [reputationStat, followerStat, albumStat])
        addSubview(statisticRow)
        statisticRow.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview()
        }
        
        // add horizontal divider
        addSubview(horizontalDividerView)
        horizontalDividerView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(statisticRow.snp.bottom)
            make.height.equalTo(1)
        }
    }
    
    private func buildStatsRow(statViews: [UIView]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: statViews)
        sv.distribution = .equalCentering
        return sv
    }
    
    private func buildStatsCol(title: String, subtitle: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .appAccent
        titleLabel.textAlignment = .center
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .boldSystemFont(ofSize: 16)
        subtitleLabel.textColor = .appGray
        
        let sv = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }
}
