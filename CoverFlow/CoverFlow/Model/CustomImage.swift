//
//  CustomImage.swift
//  CoverFlow
//
//  Created by MAC on 01.12.2020.
//

import UIKit

final class CustomImage: UIImageView {
    
    private var position: ViewManager.TypesOfImageViews?
    private var indexOfImage: Int! 
            
    var anchorWight: NSLayoutConstraint?
    var anchorHeight: NSLayoutConstraint?
    var anchorX: NSLayoutConstraint?
    var anchorY: NSLayoutConstraint?
    
    func getPosition() -> ViewManager.TypesOfImageViews {
        guard let position = position else {
            return .middle
        }
        return position
    }
    
    func changePosition(type: ViewManager.TypesOfImageViews) {
        position = type
    }
    
    func getNextIndex() -> Int {
        if indexOfImage == 12 {
        return 0
        } else {
            return indexOfImage + 1
        }
    }
    
    func getPreviousIndex() -> Int {
        if indexOfImage == 0 {
        return 12
        } else {
            return indexOfImage - 1
        }
    }
    
    func changeIndex(_ index: Int) {
        indexOfImage = index
    }
    
}
