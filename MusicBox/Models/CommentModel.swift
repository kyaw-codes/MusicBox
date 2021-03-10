//
//  CommentModel.swift
//  MusicBox
//
//  Created by Ko Kyaw on 10/03/2021.
//

import UIKit

struct CommentModel {
    
    var profileImage: UIImage
    var name: String
    var commentDuration: String
    var comment: String
    var isReacted: Bool = false
    
    static let comments: [CommentModel] = [
        .init(profileImage: UIImage(named: "pic_7")!, name: "Monica Stone", commentDuration: "5 d", comment: "This is a TL;DR thing but I've just too much to say and I can't seem to stop texting so here's my long-ass comment.", isReacted: true),
        .init(profileImage: UIImage(named: "pic_6")!, name: "Emilie Badin", commentDuration: "5 d", comment: "This is my reply 😘"),
        .init(profileImage: UIImage(named: "pic_4")!, name: "Monica Stone", commentDuration: "5 d", comment: "This is my second reply 👯‍♂️"),
        .init(profileImage: UIImage(named: "pic_3")!, name: "Joan Silverlake", commentDuration: "5 d", comment: "This is a TL;DR thing but I've just too much to say and I can't seem to stop texting so here's my long-ass comment.", isReacted: true)
    ]
}
