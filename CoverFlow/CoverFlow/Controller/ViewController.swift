//
//  ViewController.swift
//  CoverFlow
//
//  Created by MAC on 30.11.2020.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Private Properties
    
    let viewManager = ViewManager()
    let logicManager = LogicManager()
    
    var midImage: CustomImage!
    var leftImage: CustomImage!
    var rightImage: CustomImage!
    var removeImage: CustomImage!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewManager.createBackgroundImage(view: self.view)
        
        leftImage = createView(indexOfImage: 0, type: .leftOnScreen)
        midImage = createView(indexOfImage: 1, type: .middle)
        rightImage = createView(indexOfImage: 2, type: .rightOnScreen)
    }
 
    // MARK: - Private Methods
    
    private func createView(indexOfImage: Int, type: ViewManager.TypesOfImageViews) -> CustomImage {
        
        let image = CustomImage()
        image.changePosition(type: type)
        image.image = UIImage(named: logicManager.images[indexOfImage])
        image.changeIndex(indexOfImage)
        view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        viewManager.imageViewConstraint(image: image, view: self.view, type: type)
        
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        
        setGesture(on: image)
        
        return image
    }
    
    private func setGesture(on image: CustomImage) {
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:)))
        
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let tappedImage = tapGestureRecognizer.view as! CustomImage
        let position = tappedImage.getPosition()
        
            switch position {
            
            case .leftOnScreen:
      
                UIView.animate(withDuration: 1) {
                    //remove right
                    self.removeImage = self.rightImage
                    self.viewManager.sideImageToRemove(self.removeImage, type: .leftOnScreen)

                    //middle to right
                    self.viewManager.mainImageToSide(self.midImage, view: self.view, type: .rightOnScreen)
                    self.midImage.changePosition(type: .rightOnScreen)
                    self.rightImage = self.midImage
                    //left to middle
                    self.viewManager.sideImageToMain(self.leftImage, view: self.view)
                    self.leftImage.changePosition(type: .middle)
                    self.midImage = self.leftImage
                    
                    self.view.layoutIfNeeded()
                    //create new view
                    self.leftImage = self.createView(indexOfImage: self.midImage.getPreviousIndex(num: self.logicManager.images.count), type: .leftOnScreen)
                    self.leftImage.alpha = 0
                    self.leftImage.alpha = 1
                    
                } completion: { (true) in
                    self.removeImage.removeFromSuperview()
                }
                
            case .rightOnScreen:

                UIView.animate(withDuration: 1) {
                    //remove left
                    self.removeImage = self.leftImage
                    self.viewManager.sideImageToRemove(self.removeImage, type: .rightOnScreen)
                    //middle to left
                    self.viewManager.mainImageToSide(self.midImage, view: self.view, type: .leftOnScreen)
                    self.midImage.changePosition(type: .leftOnScreen)
                    self.leftImage = self.midImage
                    //right to middle
                    self.viewManager.sideImageToMain(self.rightImage, view: self.view)
                    self.rightImage.changePosition(type: .middle)
                    self.midImage = self.rightImage

                    self.view.layoutIfNeeded()
                    //create new view and remove old
                    self.rightImage = self.createView(indexOfImage: self.midImage.getNextIndex(num: self.logicManager.images.count), type: .rightOnScreen)
                    self.rightImage.alpha = 0
                    self.rightImage.alpha = 1
                    
                } completion: { (true) in
                    self.removeImage.removeFromSuperview()
                }
            default:
                break
            }
    }

}

