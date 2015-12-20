//
//  SemiDetail.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 19..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

struct SemiDetail
{
     //prime key of dataset it`s a data information
    var idx:Int
    
    var category : String      //category
    
    //semi-detail information
    var title    : String
    var cash     : String
    var address  : String
    
    
    //map information ( request, response)
    var mapPoint:(x:Int,y:Int)
    var realpos :(lat:Double,lon:Double)
    var local   :String
    
    init(ResData:AnyObject)
    {
        print(ResData);
        idx      = ResData["IDX"] as! Int!
        category = ResData["CATEGORY"] as! String
        
        title    = ResData["TITLE"] as! String
        cash     = ResData["CASH"] as! String
        address  = ResData["ADDRESS"] as! String
    
        
        mapPoint = (ResData["POSX"] as! Int,
                    ResData["POSY"] as! Int)
        
        realpos  = (ResData["LAT"] as! Double,
                    ResData["LON"] as! Double)
        
        local    = String(ResData["LOCAL"] as! String)
    }
    static func dummy() -> SemiDetail
    {
        let data:[String:AnyObject] = [
            "IDX" : 0,
            "CATEGORY" : "다목적실",
            "TITLE" : "찌누의 병특교실",
            "CASH" : "유료",
            "ADDRESS" : "서울특별시 동작구 상도 1동 112-321",
            "POSX" : 1129,
            "POSY" : 532,
            "LAT" : 127.12948939753392,
            "LON" : 37.532374273268196,
            "LOCAL" : "동작구"
        ]
        
        let result = try! NSJSONSerialization.dataWithJSONObject(data as NSDictionary,  options:  [])
        
        let json = try! NSJSONSerialization.JSONObjectWithData(result, options: [])
        return SemiDetail(ResData: json);
    }
}
struct sector
{
    var sector_idx  : (x:Int, y:Int)
    var sector_list : [SemiDetail]
}
struct Detail
{
    
}