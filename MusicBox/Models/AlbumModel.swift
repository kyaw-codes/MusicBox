//
//  AlbumModel.swift
//  MusicBox
//
//  Created by Ko Kyaw on 04/03/2021.
//

import UIKit

class AlbumModel {
    
    var coverImage: UIImage
    var title: String
    var releaseYear: String
    var numberOfTracks: Int
    var commentCount: Int
    var likeCount: Int
    
    init(coverImage: UIImage, title: String, releaseYear: String, numberOfTracks: Int, commentCount: Int, likeCount: Int) {
        self.coverImage = coverImage
        self.title = title
        self.releaseYear = releaseYear
        self.numberOfTracks = numberOfTracks
        self.commentCount = commentCount
        self.likeCount = likeCount
    }
}
