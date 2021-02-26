//
//  GradientView.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0, 0.5]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
}
