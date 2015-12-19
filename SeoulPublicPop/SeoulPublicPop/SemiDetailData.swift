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
    var target   : String
    var number   : String
    
    //map information ( request, response)
    var mapPoint:(x:Int,y:Int)
    var realpos :(lat:Double,lon:Double)
    var local   :String
    
    init(ResData ResData:AnyObject)
    {
        print(ResData);
        idx      = Int(ResData["IDX"] as! String)!
        category = String(ResData["CATEGORY"] as! String)
        
        title    = String(ResData["TITLE"] as! String)
        cash     = String(ResData["CASH"] as! String)
        target   = String(ResData["TARGET"] as! String)
        number   = String(ResData["PHONE"] as! String)
        
        mapPoint = (Int(String(ResData["POSX"] as! String))!,
                    Int(String(ResData["POSY"] as! String))!)
        
        realpos  = (Double(String(ResData["LAT"] as! String))!,
                    Double(String(ResData["LON"] as! String))!)
        local    = String(ResData["LOCAL"] as! String)
    }
    static func dummy() -> SemiDetail
    {
        var data:[String:String] = [
            "IDX" : "0",
            "CATEGORY" : "다목적실",
            "TITLE" : "찌누의 병특교실",
            "CASH" : "유료",
            "TARGET" : "상관없음",
            "PHONE" : "010-1111-2222",
            "POSX" : "1129",
            "POSY" : "532",
            "LAT" : "127.12948939753392",
            "LON" : "37.532374273268196",
            "LOCAL" : "동작구"
        ]
        
        var result = try! NSJSONSerialization.dataWithJSONObject(data as NSDictionary,  options:  [])
        
        var json = try! NSJSONSerialization.JSONObjectWithData(result, options: [])
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