//
//  StoryModel.swift
//  MusicBox
//
//  Created by Ko Kyaw on 03/03/2021.
//

import UIKit

class StoryModel: Hashable {
    
    var profile: UIImage
    var name: String
    var isMyStory: Bool
    
    init(profile: UIImage, name: String, isMyStory: Bool = false) {
        self.profile = profile
        self.name = name
        self.isMyStory = isMyStory
    }
    
    static func == (lhs: StoryModel, rhs: StoryModel) -> Bool {
        return lhs.profile == rhs.profile
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(profile)
    }
    
}
