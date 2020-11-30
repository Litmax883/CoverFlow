//
//  ViewController.swift
//  CoverFlow
//
//  Created by MAC on 30.11.2020.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    var numberOfImage = 0
    
    private var images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transformImages()
        
    }
    
    // MARK: - Public Methods
    
    
    // MARK: - Private Methods
    
    private func transformImages() {
        var leftImageTransform = CATransform3DIdentity
        leftImageTransform.m34 = 1 / -500
        leftImageTransform = CATransform3DRotate(leftImageTransform, 70, 0, 1, 0)
        
        var rightImageTransform = CATransform3DIdentity
        rightImageTransform.m34 = 1 / 500
        rightImageTransform = CATransform3DRotate(rightImageTransform, 70, 0, 1, 0)
        
        leftImage.layer.transform = leftImageTransform
        rightImage.layer.transform = rightImageTransform
        
        leftImage.layer.zPosition = -300
        rightImage.layer.zPosition = -300
    }
    
    private func setGestures() {
        
        let tapLeftGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapRightGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:)))
        leftImage.isUserInteractionEnabled = true
        rightImage.isUserInteractionEnabled = true
        rightImage.addGestureRecognizer(tapRightGestureRecognizer)
        leftImage.addGestureRecognizer(tapLeftGestureRecognizer)
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if numberOfImage < 10 {
            mainImage.image = tappedImage.image
            tappedImage.image = UIImage(named: images[numberOfImage])
            numberOfImage += 1
        } else {
            mainImage.image = tappedImage.image
            tappedImage.image = UIImage(named: images[0])
            numberOfImage = 1
        }
    }
    
    // MARK: - IBActions
    
    
}

