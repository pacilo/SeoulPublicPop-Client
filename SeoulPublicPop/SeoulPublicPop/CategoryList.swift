//
//  CategoryListController.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 11. 26..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

class CategoryList: CategoryModel {
    
    class func allCategory() -> [CategoryList] {
        var categoryList = [CategoryList]()
        if let URL = NSBundle.mainBundle().URLForResource("CategoryList", withExtension: "plist") {
            if let categoryFromPlist = NSArray(contentsOfURL: URL) {
                for dictionary in categoryFromPlist {
                    let getDictionary = CategoryList(dictionary: dictionary as! NSDictionary)
                    categoryList.append(getDictionary)
                }
            }
        }
        return categoryList
    }
    
}
