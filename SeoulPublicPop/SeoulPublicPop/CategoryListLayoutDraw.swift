//
//  CategoryListLayoutDraw.swift
//  SeoulPublicPop
//  Modified by pacilo on 2015. 11. 26..
//
//  Created by Mic Pringle on 27/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//


import UIKit


var IS_IPAD: Bool {
get {
    if (UIDevice.currentDevice().userInterfaceIdiom == .Pad) {
        return true
    }
    else {
        return false
    }
}
}

var IS_IPHONE: Bool {
get {
    if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
        return true
    }
    else {
        return false
    }
}
}

var IS_RETINA: Bool {
get {
    if (UIScreen.mainScreen().scale >= 2.0) {
        return true
    }
    else {
        return false
    }
}
}

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

var SCREEN_MAX_LENGTH: CGFloat {
get {
    return SCREEN_WIDTH < SCREEN_HEIGHT ? SCREEN_HEIGHT : SCREEN_WIDTH
}
}

var SCREEN_MIN_LENGTH: CGFloat {
get {
    return SCREEN_WIDTH < SCREEN_HEIGHT ? SCREEN_HEIGHT : SCREEN_WIDTH
}
}

let IS_IPHONE_4_OR_LESS: Float = 4.0
let IS_IPHONE_5: Float = 5.0
let IS_IPHONE_6: Float = 6.0
let IS_IPHONE_6P: Float = 6.5

var MY_DEVICE: Float {
get {
    if (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0) {
        return IS_IPHONE_6P
    }
    else if (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0) {
        return IS_IPHONE_6
    }
    else if (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0) {
        return IS_IPHONE_5
    }
    else {
        return IS_IPHONE_4_OR_LESS
    }
}
}


/* The heights are declared as constants outside of the class so they can be easily referenced elsewhere */
struct CategoryLayoutConstants {
    struct Cell {
        /* The height of the non-featured cell */
        static let standardHeight: CGFloat = 100
        /* The height of the first visible cell */
        static let featuredHeight: CGFloat = 280
    }
}

class CategoryListLayoutDraw: UICollectionViewLayout {
    
    // MARK: Properties and Variables
    
    /* The amount the user needs to scroll before the featured cell changes */
    var dragOffset: CGFloat {
        get {
            if MY_DEVICE == IS_IPHONE_4_OR_LESS {
                return 100.0
            }
            else if MY_DEVICE == IS_IPHONE_5 {
                return 105.0
            }
            else if MY_DEVICE == IS_IPHONE_6 {
                return 140.0
            }
            else {
                return 115.0
            }
        }
    }
        
    var cache = [UICollectionViewLayoutAttributes]()
    
    /* Returns the item index of the currently featured cell */
    var featuredItemIndex: Int {
        get {
            /* Use max to make sure the featureItemIndex is never < 0 */
            return max(0, Int(collectionView!.contentOffset.y / dragOffset))
        }
    }
    
    /* Returns a value between 0 and 1 that represents how close the next cell is to becoming the featured cell */
    var nextItemPercentageOffset: CGFloat {
        get {
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
        }
    }
    
    /* Returns the width of the collection view */
    var width: CGFloat {
        get {
            return CGRectGetWidth(collectionView!.bounds)
        }
    }
    
    /* Returns the height of the collection view */
    var height: CGFloat {
        get {
            return CGRectGetHeight(collectionView!.bounds)
        }
    }
    
    /* Returns the number of items in the collection view */
    var numberOfItems: Int {
        get {
            return collectionView!.numberOfItemsInSection(0)
        }
    }
    
    // MARK: UICollectionViewLayout
    
    /* Return the size of all the content in the collection view */
    override func collectionViewContentSize() -> CGSize {
        let contentHeight = CGFloat(numberOfItems - 1) * dragOffset + CategoryLayoutConstants.Cell.featuredHeight
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepareLayout() {
        cache.removeAll(keepCapacity: false)
        
        let standardHeight = CategoryLayoutConstants.Cell.standardHeight
        let featuredHeight = CategoryLayoutConstants.Cell.featuredHeight
        
        var frame = CGRectZero
        var y: CGFloat = 0
        
        for item in 0 ..< numberOfItems {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            /* Important because each cell has to slide over the top of the previous one */
            attributes.zIndex = item
            /* Initially set the height of the cell to the standard height */
            var height = standardHeight
            if indexPath.item == featuredItemIndex {
                /* The featured cell */
                let yOffset = standardHeight * nextItemPercentageOffset
                y = collectionView!.contentOffset.y - yOffset
                height = featuredHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                /* The cell directly below the featured cell, which grows as the user scrolls */
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = CGRectGetMaxY(frame)
        }
    }
    
    /* Return all attributes in the cache whose frame intersects with the rect passed to the method */
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    /* Return the content offset of the nearest cell which achieves the nice snapping effect, similar to a paged UIScrollView */
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.y / dragOffset)
        let yOffset = itemIndex * dragOffset
        return CGPoint(x: 0, y: yOffset)
    }
    
    /* Return true so that the layout is continuously invalidated as the user scrolls */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
}
