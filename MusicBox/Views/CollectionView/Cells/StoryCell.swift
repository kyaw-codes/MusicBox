//
//  StoryCell.swift
//  MusicBox
//
//  Created by Ko Kyaw on 01/03/2021.
//

import UIKit
import SnapKit

class StoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
