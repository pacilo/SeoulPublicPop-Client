//
//  DetailData.swift
//  SeoulPublicPop-Client
//
//  Created by 최윤호 on 2015. 12. 21..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

struct Detail
{
    var idx : Int
    var category : String
    var title : String
    var place : String
    var payat : String
    var recp  : String
    var address : String
    var tel   : String
    var internet  : String
    var lat : Double
    var lon : Double
    var local : String
    init(ResData:AnyObject)
    {
        idx      = ResData["IDX"] as! Int!
        category = ResData["CATEGORY"] as! String
        place    = ResData["PLACE"] as! String
        title    = ResData["TITLE"] as! String
        payat    = ResData["CASH"] as! String
        recp     = ResData["RECP"] as! String
        address  = ResData["ADDRESS"] as! String
        tel      = ResData["TEL"] as! String
        internet = ResData["EADRS"] as! String
        
        lat = ResData["LAT"] as! Double
        lon = ResData["LON"] as! Double
        
        
        local    = String(ResData["LOCAL"] as! String)
    }
}