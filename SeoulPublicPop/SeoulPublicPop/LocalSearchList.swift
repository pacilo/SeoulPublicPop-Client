//
//  LocalSearchList.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 19..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

class LocationInfoList: LocationInfoModel {
    
    class func getLocationInfo() -> [LocationInfoModel] {
        var locationInfoList = [LocationInfoList]()
        if let URL = NSBundle.mainBundle().URLForResource("LocationInfo", withExtension: "plist") {
            if let locationInfoFromPlist = NSArray(contentsOfURL: URL) {
                for dictionary in locationInfoFromPlist {
                    let getDictionary = LocationInfoList(dictionary: dictionary as! NSDictionary)
                    locationInfoList.append(getDictionary)
                }
            }
        }
        return locationInfoList
    }
    
}