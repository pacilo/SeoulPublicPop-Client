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
    var localhash : [String : [String] ]
    private init(){
        poshash = [:]
        localhash = [:]
    }
    
}