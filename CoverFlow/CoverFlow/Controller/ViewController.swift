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
    
    private var numberOfImage = 3 {
        didSet {
            if numberOfImage == 10 {
                self.numberOfImage = 0
                print(numberOfImage)
            }
        }
    }
    
    private var images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        midImage = createView(name: images[1], type: .middle)
        leftImage = createView(name: images[0], type: .leftOnScreen)
        rightImage = createView(name: images[2], type: .rightOnScreen)
        
    }
    
    
    // MARK: - Private Methods
    private func createView(name: String, type: ViewManager.TypesOfImageViews) -> CustomImage {
        
        let image = CustomImage()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.changePosition(type: type)
        image.image = UIImage(named: name)
        view.addSubview(image)
        viewManager.transformImages(image: image, type: type)
        viewManager.imageViewConstraint(image: image, view: self.view, type: type)
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
        self.numberOfImage += 1
        
            switch position {
            
            case .leftOnScreen:
                
      
                UIView.animate(withDuration: 1) {
                    _ = self.createView(name: self.images[self.numberOfImage], type: .leftOnScreen)
                    
                    self.viewManager.sideImageToMain(self.leftImage, view: self.view)
                    self.leftImage.changePosition(type: .middle)
                    
//                    self.midImage.transform = CGAffineTransform(translationX: 200, y: 0)
//                    self.midImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//                    self.viewManager.transformImages(image: self.midImage, type: .rightOnScreen)
//                    self.midImage.changePosition(type: .rightOnScreen)
                }
                
                self.rightImage.removeFromSuperview()

            case .rightOnScreen:
                
                _ = self.createView(name: self.images[self.numberOfImage], type: .rightOnScreen)
      
                UIView.animate(withDuration: 1) {
                    
                    self.rightImage.transform = CGAffineTransform(translationX: 200, y: 0)
                    self.rightImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    self.viewManager.sideImageToMain(self.rightImage, view: self.view)
                    self.rightImage.changePosition(type: .middle)
                    
                    self.midImage.transform = CGAffineTransform(translationX: -200, y: 0)
                    self.midImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    self.viewManager.transformImages(image: self.midImage, type: .leftOnScreen)
                    self.midImage.changePosition(type: .leftOnScreen)
                }
                
                self.leftImage.removeFromSuperview()
      
                
            default:
                print("Other")
            }
        
    }
    
//    UIView.animate(withDuration: 2.0) {
//        self.redTopView.transform = CGAffineTransform(translationX: -160, y: 0)
//        self.redBottomView.transform = CGAffineTransform(translationX: -160, y: 0)
//        self.blueTopView.transform = CGAffineTransform(translationX: -160, y: 0)
//        self.blueBottomView.transform = CGAffineTransform(translationX: -160, y: 0)
//    }
    
}

