//
//  CategoryListViewCell.swift
//  SeoulPublicPop
//  Modified by pacilo on 2015. 11. 26..
//
//  Created by Mic Pringle on 27/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class CategoryListViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageCoverView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var categoryList: CategoryList? {
        didSet {
            if let categoryList = categoryList {
                imageView.image = categoryList.backgroundImage
                titleLabel.text = categoryList.title
            }
        }
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let featuredHeight = CategoryLayoutConstants.Cell.featuredHeight
        let standardHeight = CategoryLayoutConstants.Cell.standardHeight
        
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.2
        let maxAlpha: CGFloat = 0.8
        
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        titleLabel.transform = CGAffineTransformMakeScale(scale, scale)
    }
    
}
