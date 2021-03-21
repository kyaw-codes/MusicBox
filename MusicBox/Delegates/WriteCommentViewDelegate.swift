//
//  WriteCommentViewDelegate.swift
//  MusicBox
//
//  Created by Ko Kyaw on 11/03/2021.
//

import Foundation

protocol WriteCommentViewDelegate {
    
    /// WriteCommentView will call this method when emoji picker is tapped.
    /// Implement this method to show emoji picker view controller in the client view.
    func onEmojiPickerTap()
    
    /// WriteCommentView will trigger this method when send button is tapped.
    func onSendButtonTap()
}
