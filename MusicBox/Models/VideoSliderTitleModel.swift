//
//  VideoSliderTitleModel.swift
//  MusicBox
//
//  Created by Ko Kyaw on 01/03/2021.
//

import Foundation

class VideoSliderTitleModel: Hashable {
    
    var title: String
    var isSelected: Bool = false
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }

    static func == (lhs: VideoSliderTitleModel, rhs: VideoSliderTitleModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(title)
    }
    
}
