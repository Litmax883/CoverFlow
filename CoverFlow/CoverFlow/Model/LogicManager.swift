//
//  LogicManager.swift
//  CoverFlow
//
//  Created by MAC on 03.12.2020.
//

import UIKit

final class LogicManager {
    
    var images: [String] = []
    
    init() {
        createArray()
    }
    
    private func createArray() {
        for i in 1... {
            let image = UIImage(named: "image\(i)")
            if image != nil {
            images.append("image\(i)")
            } else {
                break
            }
        }
    }

}
