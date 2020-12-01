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
            image.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            image.heightAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -120).isActive = true
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            transformImages(image: image, type: type)
        
        case .middle:
            image.widthAnchor.constraint(equalToConstant: view.frame.width / 1.6).isActive = true
            image.heightAnchor.constraint(equalToConstant: view.frame.width / 1.6).isActive = true
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        case .rightOnScreen:
            image.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            image.heightAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 120).isActive = true
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            transformImages(image: image, type: type)
        }
    }
    
    func transformImages(image: CustomImage, type: TypesOfImageViews) {
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
    
    func sideImageToMain(_ image: CustomImage, view: UIView) {
        
        var imageTransform = CATransform3DIdentity
        imageTransform.m34 = 0
        imageTransform = CATransform3DRotate(imageTransform, 0, 0, 0, 0)
        image.layer.transform = imageTransform
        
        
        view.setNeedsLayout()
        
        image.layer.zPosition = 100
    }

    
}
