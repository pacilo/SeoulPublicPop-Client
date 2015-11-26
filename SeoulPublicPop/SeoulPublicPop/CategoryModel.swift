//
//  CategoryListModel.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 11. 26..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

class CategoryModel {
    
    var title: String
    var backgroundImage: UIImage
    
    init(title: String, backgroundImage: UIImage) {
        self.title = title
        self.backgroundImage = backgroundImage
    }
    
    convenience init(dictionary: NSDictionary) {
        let title = dictionary["Title"] as? String
        let backgroundName = dictionary["Background"] as? String
        let backgroundImage = UIImage(named: backgroundName!)
        self.init(title: title!, backgroundImage: backgroundImage!.decompressedImage)
    }
}

extension UIImage {
    
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        drawAtPoint(CGPointZero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage
    }
    
}
