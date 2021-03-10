//
//  SearchBarCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 10/03/2021.
//

import UIKit
import SnapKit

class SearchBarCell: UICollectionViewCell {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Artists, songs, albums..."
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.barTintColor = .searchBarBackground
        searchBar.searchTextField.textColor = .systemGray
        searchBar.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemGray), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.font = .systemFont(ofSize: 18, weight: .semibold)
        searchBar.layer.cornerRadius = frame.height / 2
        searchBar.clipsToBounds = true
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
