//
//  File.swift
//  MusicBox
//
//  Created by Ko Kyaw on 10/03/2021.
//

import UIKit

struct WatchedVideoModel {
    
    var coverImage: UIImage
    var title: String
    var status: Status
    var viewerCounts: String
    
    static let continueWatchingVideos: [WatchedVideoModel] = [
        .init(coverImage: UIImage(named: "vid_1")!, title: "Wanna Be You", status: .CONTINUE_WATCHING, viewerCounts: "2.5M"),
        .init(coverImage: UIImage(named: "vid_2")!, title: "Let's Be Us", status: .CONTINUE_WATCHING, viewerCounts: "4.5M"),
        .init(coverImage: UIImage(named: "vid_3")!, title: "What a Dream!", status: .CONTINUE_WATCHING, viewerCounts: "3.8M")
    ]
    
    static let watchedVideos: [WatchedVideoModel] = [
        .init(coverImage: UIImage(named: "vid_4")!, title: "I Like A Lot", status: .WATCHED, viewerCounts: "2.5M"),
        .init(coverImage: UIImage(named: "vid_5")!, title: "Amour", status: .WATCHED, viewerCounts: "4.5M"),
        .init(coverImage: UIImage(named: "vid_6")!, title: "Kings & Queens", status: .WATCHED, viewerCounts: "4.5M"),
        .init(coverImage: UIImage(named: "vid_7")!, title: "B.E.E.F", status: .WATCHED, viewerCounts: "3.8M")
    ]
    
    enum Status {
        case WATCHED, CONTINUE_WATCHING
    }
}
