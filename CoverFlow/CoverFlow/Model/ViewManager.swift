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
    
    func createBackgroundImage(view: UIView) {
        
        let image = UIImageView()
        image.image = UIImage(named: "bgImage1")
        image.layer.zPosition = -1000
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    
    func imageViewConstraint(image: CustomImage, view: UIView, type: TypesOfImageViews) {
        let lessSideConstant = view.frame.width < view.frame.height ? view.frame.width : view.frame.height
        
        switch type {
        case .leftOnScreen:
            
            let width = image.widthAnchor.constraint(equalToConstant: lessSideConstant / 2)
            let height = image.heightAnchor.constraint(equalToConstant: lessSideConstant / 2)
            let x = image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -lessSideConstant / 3.45)
            let y = image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            NSLayoutConstraint.activate([width, height, x, y])
            
            image.anchorWight = width
            image.anchorHeight = height
            image.anchorX = x
            image.anchorY = y
            
            transformImage(image: image, type: type)
            
        case .middle:
            
            let width = image.widthAnchor.constraint(equalToConstant: lessSideConstant / 1.6)
            let height = image.heightAnchor.constraint(equalToConstant: lessSideConstant / 1.6)
            let x = image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            let y = image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            NSLayoutConstraint.activate([width, height, x, y])
            
            image.anchorWight = width
            image.anchorHeight = height
            image.anchorX = x
            image.anchorY = y
            
        case .rightOnScreen:
            
            let width = image.widthAnchor.constraint(equalToConstant: lessSideConstant / 2)
            let height = image.heightAnchor.constraint(equalToConstant: lessSideConstant / 2)
            let x = image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: lessSideConstant / 3.45)
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
    
    func sideImageToMain(_ image: CustomImage, view: UIView) {
        let lessSideConstant = view.frame.width < view.frame.height ? view.frame.width : view.frame.height
        
        var imageTransform = CATransform3DIdentity
        imageTransform.m34 = 0
        imageTransform = CATransform3DRotate(imageTransform, 0, 0, 0, 0)
        image.layer.transform = imageTransform
        
        image.anchorHeight?.constant = lessSideConstant / 1.6
        image.anchorWight?.constant = lessSideConstant / 1.6
        image.anchorX?.constant = 0
        image.anchorY?.constant = 0
        
        image.layer.zPosition = 300
    }
    
    func mainImageToSide(_ image: CustomImage, view: UIView, type: TypesOfImageViews) {
        let lessSideConstant = view.frame.width < view.frame.height ? view.frame.width : view.frame.height

        if type == .leftOnScreen {
            
            image.anchorHeight?.constant = lessSideConstant / 2
            image.anchorWight?.constant = lessSideConstant / 2
            image.anchorX?.constant = -lessSideConstant / 3.45
            image.anchorY?.constant = 0
            
            self.transformImage(image: image, type: type)
        } else if type == .rightOnScreen {
            
            image.anchorHeight?.constant = lessSideConstant / 2
            image.anchorWight?.constant = lessSideConstant / 2
            image.anchorX?.constant = lessSideConstant / 3.45
            image.anchorY?.constant = 0
            
            self.transformImage(image: image, type: type)
        }
        image.layer.zPosition = -200
    }
    
    func sideImageToRemove(_ image: CustomImage, type: TypesOfImageViews) {
        
        if type == .leftOnScreen {
            image.anchorX?.constant += 150
        } else if type == .rightOnScreen {
            image.anchorX?.constant -= 150
        }
        image.alpha = 0
        image.layer.zPosition = -500
    }
    
}
