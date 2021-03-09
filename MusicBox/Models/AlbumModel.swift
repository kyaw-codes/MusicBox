//
//  AlbumModel.swift
//  MusicBox
//
//  Created by Ko Kyaw on 04/03/2021.
//

import UIKit

class AlbumModel {
    
    var coverImage: UIImage
    var artistImage: UIImage
    var title: String
    var artistName: String
    var artistBio: String
    var releaseYear: String
    var numberOfTracks: Int
    var commentCount: Int
    var likeCount: Int
    
    init(coverImage: UIImage, artistImage: UIImage, title: String, artistName: String, artistBio: String, releaseYear: String, numberOfTracks: Int, commentCount: Int, likeCount: Int) {
        self.coverImage = coverImage
        self.artistImage = artistImage
        self.title = title
        self.artistName = artistName
        self.artistBio = artistBio
        self.releaseYear = releaseYear
        self.numberOfTracks = numberOfTracks
        self.commentCount = commentCount
        self.likeCount = likeCount
    }
}
