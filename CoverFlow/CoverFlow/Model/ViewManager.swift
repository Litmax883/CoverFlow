//
//  ViewManager.swift
//  CoverFlow
//
//  Created by MAC on 01.12.2020.
//

import UIKit

final class ViewManager {
    
    enum TypesOfImageViews {
        case leftOnScreen
        case middle
        case rightOnScreen
    }
    
    func imageViewConstraint(image: CustomImage, view: UIView, type: TypesOfImageViews) {
        
        switch type {
        
        case .leftOnScreen:
            
            let width = image.widthAnchor.constraint(equalToConstant: view.frame.width / 2)
            let height = image.heightAnchor.constraint(equalToConstant: view.frame.width / 2)
            let x = image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -120)
            let y = image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            NSLayoutConstraint.activate([width, height, x, y])
            image.anchorWight = width
            image.anchorHeight = height
            image.anchorX = x
            image.anchorY = y
            
            transformImage(image: image, type: type)
            
        case .middle:
            
            let width = image.widthAnchor.constraint(equalToConstant: view.frame.width / 1.6)
            let height = image.heightAnchor.constraint(equalToConstant: view.frame.width / 1.6)
            let x = image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            let y = image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            NSLayoutConstraint.activate([width, height, x, y])
            image.anchorWight = width
            image.anchorHeight = height
            image.anchorX = x
            image.anchorY = y
            
        case .rightOnScreen:
            
            let width = image.widthAnchor.constraint(equalToConstant: view.frame.width / 2)
            let height = image.heightAnchor.constraint(equalToConstant: view.frame.width / 2)
            let x = image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 120)
            let y = image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            NSLayoutConstraint.activate([width, height, x, y])
            image.anchorWight = width
            image.anchorHeight = height
            image.anchorX = x
            image.anchorY = y
            transformImage(image: image, type: type)
        }
    }
    
    func transformImage(image: CustomImage, type: TypesOfImageViews) {
        var imageTransform = CATransform3DIdentity
        
        if type == .leftOnScreen {
            imageTransform.m34 = 1 / -500
            imageTransform = CATransform3DRotate(imageTransform, 70, 0, 1, 0)
        } else if type == .rightOnScreen {
            imageTransform.m34 = 1 / 500
            imageTransform = CATransform3DRotate(imageTransform, 70, 0, 1, 0)
        }
        image.layer.transform = imageTransform
        image.layer.zPosition = -300
    }
    
    func sideImageToMain(_ image: CustomImage) {
        
        var imageTransform = CATransform3DIdentity
        imageTransform.m34 = 0
        imageTransform = CATransform3DRotate(imageTransform, 0, 0, 0, 0)
        image.layer.transform = imageTransform
        
        image.anchorHeight?.constant = 250
        image.anchorWight?.constant = 250
        image.anchorX?.constant = 0
        image.anchorY?.constant = 0
        
        image.layer.zPosition = 300
    }
    
    func mainImageToSide(_ image: CustomImage, type: TypesOfImageViews) {
        if type == .leftOnScreen {
            image.anchorHeight?.constant = 200
            image.anchorWight?.constant = 200
            image.anchorX?.constant = -120
            image.anchorY?.constant = 0
            self.transformImage(image: image, type: type)
        } else if type == .rightOnScreen {
            image.anchorHeight?.constant = 200
            image.anchorWight?.constant = 200
            image.anchorX?.constant = 120
            image.anchorY?.constant = 0
            self.transformImage(image: image, type: type)
        }
        image.layer.zPosition = -200
    }
    
    func sideImageToRemove(_ image: CustomImage, type: TypesOfImageViews) {
        
        var imageTransform = CATransform3DIdentity
        
        if type == .leftOnScreen {
            imageTransform.m34 = 1 / 100
            imageTransform = CATransform3DRotate(imageTransform, 70, 0, 1, 0)
            image.anchorX?.constant += 150
        } else if type == .rightOnScreen {
            imageTransform.m34 = 1 / -100
            imageTransform = CATransform3DRotate(imageTransform, 70, 0, 1, 0)
            image.anchorX?.constant -= 150
        }
        image.alpha = 0.2
        image.layer.transform = imageTransform
        image.layer.zPosition = -500
        
    }
    
    
}
