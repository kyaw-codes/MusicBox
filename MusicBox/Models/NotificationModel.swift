//
//  NotificationModel.swift
//  MusicBox
//
//  Created by Ko Kyaw on 21/03/2021.
//

import UIKit

struct NotificationModel: Hashable {
    
    let id = UUID()
    var name: String
    var profileImage: UIImage
    var time: String
    var type: NotificationType
    
    static var notifications: [NotificationModel] = [
        .init(name: "Tyson Marlo", profileImage: UIImage(named: "pic_2")!, time: "30m", type: .like),
        .init(name: "Joan Silverlake", profileImage: UIImage(named: "pic_4")!, time: "1h", type: .follow),
        .init(name: "Zoe Almond", profileImage: UIImage(named: "pic_5")!, time: "1h", type: .like),
        .init(name: "Zoe Almond", profileImage: UIImage(named: "pic_5")!, time: "1h", type: .follow),
        .init(name: "Joan Silverlake", profileImage: UIImage(named: "pic_4")!, time: "2h", type: .reply),
        .init(name: "Linzy", profileImage: UIImage(named: "pic_7")!, time: "2h", type: .reply),
        .init(name: "Tyson Marlo", profileImage: UIImage(named: "pic_2")!, time: "3h", type: .like)
    ]
    
    public enum NotificationType {
        case like
        case follow
        case reply
        
        var humanReadableText: String {
            switch self {
            case .like:
                return "liked to your song."
            case .follow:
                return "started following you!"
            default:
                return "replied to your comment."
            }
        }
    }
}
