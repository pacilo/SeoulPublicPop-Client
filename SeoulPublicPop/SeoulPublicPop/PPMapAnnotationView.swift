//
//  PPMapAnnotationView.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 10. 30..
//  Copyright © 2015년 DAYEONSSI. All rights reserved.
//

import UIKit
import MapKit

class PPMapAnnotationView: MKAnnotationView {
    var countlabel : UILabel?
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // Called when drawing the AttractionAnnotationView
    override init(frame: CGRect) {
        frame
        super.init(frame: frame)
    }
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
     //   if self.annotation is PPMapAnnotation
    //   {
        let ppano = self.annotation as! PPMapAnnotation
        image = imageResize(UIImage(named : "testAnnotationIcon")!,sizeChange: CGSize(width:40, height: 40))
        layer.cornerRadius = frame.size.width / 2
        backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        
        countlabel = UILabel(frame: frame)
        countlabel!.text = String((annotation as! PPMapAnnotation).getMyCount())
        countlabel!.textAlignment = NSTextAlignment.Center
        countlabel!.textColor = UIColor(red: CGFloat(0xff)/255, green: CGFloat(0xd7)/255, blue: CGFloat(0x00)/255, alpha: 0.6)
        countlabel!.center = CGPointMake(frame.size.width  / 2, frame.size.height / 2);
        self.alpha = 0.5
        addSubview(countlabel!)
        //   }
    }
    func imageResize(imageObj:UIImage, sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // !!!
        return scaledImage
    }
}
