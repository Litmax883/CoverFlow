//
//  CustomImage.swift
//  CoverFlow
//
//  Created by MAC on 01.12.2020.
//

import UIKit

final class CustomImage: UIImageView {
    
    private var position: ViewManager.TypesOfImageViews?
            
    var anchorWight: NSLayoutConstraint?
    var anchorHeight: NSLayoutConstraint?
    var anchorX: NSLayoutConstraint?
    var anchorY: NSLayoutConstraint?
    
    func getPosition () -> ViewManager.TypesOfImageViews {
        guard let position = position else {
            return .middle
        }
        return position
    }
    
    func changePosition(type: ViewManager.TypesOfImageViews) {
        position = type
    }
    
}
