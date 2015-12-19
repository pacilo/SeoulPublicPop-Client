//
//  DataCenter.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 19..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

class DataCenter {
    static private var center:DataCenter = DataCenter()
    static func getInstance()->DataCenter { return center }
    
    var poshash:[Int : [String] ]
    var localhash : [String : [SemiDetail] ]
    
    private init(){
        poshash = [:]
        localhash = [:]
        
        localhash["동작구"] = dummy()
    }
    func dummy() -> [SemiDetail]
    {
        var result:[SemiDetail] = []
        
        result.append(SemiDetail.dummy())
        result.append(SemiDetail.dummy())
        result.append(SemiDetail.dummy())
        result.append(SemiDetail.dummy())
        
        return result
    }
    
    func getData(local:String) -> [SemiDetail]?
    {
        return localhash[local]
    }
    func getData(point:(x:Int,y:Int)) -> [SemiDetail]?
    {
        return nil
    }
}