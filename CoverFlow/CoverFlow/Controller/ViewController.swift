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
    
    var midImage: CustomImage!
    var leftImage: CustomImage!
    var rightImage: CustomImage!
    var removeImage: CustomImage!
    
    private var numberOfImage = 3 {
        didSet {
            if numberOfImage == 10 {
                self.numberOfImage = 0
            } else if numberOfImage < 0 {
                self.numberOfImage = 9
            }
        }
    }
    
    private var images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftImage = createView(name: images[0], type: .leftOnScreen)
        midImage = createView(name: images[1], type: .middle)
        rightImage = createView(name: images[2], type: .rightOnScreen)
        
    }
 
    // MARK: - Private Methods
    
    private func createView(name: String, type: ViewManager.TypesOfImageViews) -> CustomImage {
        
        let image = CustomImage()
        image.changePosition(type: type)
        image.image = UIImage(named: name)
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
                self.numberOfImage += 1
      
                UIView.animate(withDuration: 1) {
                    //remove right
                    self.removeImage = self.rightImage
                    self.viewManager.sideImageToRemove(self.removeImage, type: .leftOnScreen)

                    //middle to right
                    self.viewManager.mainImageToSide(self.midImage, type: .rightOnScreen)
                    self.midImage.changePosition(type: .rightOnScreen)
                    self.rightImage = self.midImage
                    //left to middle
                    self.viewManager.sideImageToMain(self.leftImage)
                    self.leftImage.changePosition(type: .middle)
                    self.midImage = self.leftImage
                    
                    self.view.layoutIfNeeded()
                    //create new view
                    self.leftImage = self.createView(name: self.images[self.numberOfImage], type: .leftOnScreen)
                    self.leftImage.alpha = 0
                    self.leftImage.alpha = 1
                } completion: { (true) in
                    self.removeImage.removeFromSuperview()
                }
                
            case .rightOnScreen:
                self.numberOfImage -= 1

                UIView.animate(withDuration: 1) {
                    //remove left
                    self.removeImage = self.leftImage
                    self.viewManager.sideImageToRemove(self.removeImage, type: .rightOnScreen)
                    //middle to left
                    self.viewManager.mainImageToSide(self.midImage, type: .leftOnScreen)
                    self.midImage.changePosition(type: .leftOnScreen)
                    self.leftImage = self.midImage
                    //right to middle
                    self.viewManager.sideImageToMain(self.rightImage)
                    self.rightImage.changePosition(type: .middle)
                    self.midImage = self.rightImage

                    self.view.layoutIfNeeded()
                    //create new view and remove old
                    self.rightImage = self.createView(name: self.images[self.numberOfImage], type: .rightOnScreen)
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

