//
//  UIView+extension.swift
//  MusicBox
//
//  Created by Ko Kyaw on 11/03/2021.
//

import UIKit

extension UIView {
    
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        return applyGradient(colours: colours, locations: locations, frame: nil)
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, frame: CGRect?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations

        if let frame = frame {
            gradient.frame = frame
        }
        
        self.layer.insertSublayer(gradient, at: 0)
        
        return gradient
    }
}
