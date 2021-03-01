//
//  VideoSliderHeader+Delegate.swift
//  MusicBox
//
//  Created by Ko Kyaw on 01/03/2021.
//

import UIKit

extension VideoSliderHeader: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = sliderTitles[indexPath.item].title
        let textWidth = String(title).size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]).width
        return CGSize(width: textWidth + 10, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
}
