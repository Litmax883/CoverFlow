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
    
    var leftImage: UIImageView!
    var midImage: UIImageView!
    var rightImage: UIImageView!
    
    
    private var numberOfImage = 3
    
    private var images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftImage = createView(name: images[0], type: .leftOnScreen)
        midImage = createView(name: images[1], type: .middle)
        rightImage = createView(name: images[2], type: .rightOnScreen)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - Private Methods
    private func createView(name: String, type: ViewManager.TypesOfImageViews) -> UIImageView {
        
        let image = viewManager.createImageView()
        image.image = UIImage(named: name)
        view.addSubview(image)
        viewManager.imageViewConstraint(image: image, view: self.view, type: type)
        setGesture(image: image, type: type)
        
        return image
    }
    
    
    private func setGesture(image: UIImageView, type: ViewManager.TypesOfImageViews) {

        if type == .middle {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:)))

        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        }
        
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        UIView.animate(withDuration: 1) {
            
            print("ffff")

        }
    }
    


}

