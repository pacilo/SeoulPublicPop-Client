//
//  LocalSearchModel.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 19..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

class LocationInfoModel {
    
    var localName: String
    var coordinates: NSArray//[Dictionary<Float, Float>]
    
    init(localName: String, coordinates: NSArray) {
        self.localName = localName
        self.coordinates = coordinates
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["LocationName"] as? String
        let coordinateList = dictionary["Coordinates"] as? NSArray
        self.init(localName: name!, coordinates: coordinateList!)
    }

}