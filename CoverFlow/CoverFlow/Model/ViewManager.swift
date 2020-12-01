//
//  ViewManager.swift
//  CoverFlow
//
//  Created by MAC on 01.12.2020.
//

import UIKit

final class ViewManager {
    
    enum TypesOfImageViews {
        case leftHidden
        case leftOnScreen
        case middle
        case rightOnScreen
        case rightHidden
    }
    
    func createImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func imageViewConstraint(image: UIImageView, view: UIView, type: TypesOfImageViews) {
        
        switch type {
        case .leftHidden:
            image.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            image.heightAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -220).isActive = true
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            transformImages(image: image, type: type)
        
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
        
        case .rightHidden:
            image.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            image.heightAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 220).isActive = true
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            transformImages(image: image, type: type)
        }
    }
    
    func transformImages(image: UIImageView, type: TypesOfImageViews) {
        var imageTransform = CATransform3DIdentity
        
        if type == .leftHidden || type == .leftOnScreen {
            imageTransform.m34 = 1 / -500
            imageTransform = CATransform3DRotate(imageTransform, 70, 0, 1, 0)
        } else if type == .rightHidden || type == .rightOnScreen {
            imageTransform.m34 = 1 / 500
            imageTransform = CATransform3DRotate(imageTransform, 70, 0, 1, 0)
        }
            image.layer.transform = imageTransform
            image.layer.zPosition = -300
    }
    
    func sideImageToMain(_ image: UIImageView, view: UIView) {
        
        var imageTransform = CATransform3DIdentity
        imageTransform.m34 = 0
        imageTransform = CATransform3DRotate(imageTransform, 0, 0, 0, 0)
        image.layer.transform = imageTransform
        image.frame.size.height = view.frame.width / 1.6
        image.frame.size.width = view.frame.width / 1.6
        
        image.center.y = view.bounds.height / 2
        image.center.x = view.bounds.width / 2
        
        image.layer.zPosition = 100
    }
    
    
    
    
    
}
