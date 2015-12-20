//
//  Local.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 20..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

class Local : Hashable {
    var category : String
    var local : String
    
    var chunk : LocalRequest;
    var data : [SemiDetail];
    var maxsize : Int;
    var dirty : Bool;
    var hashValue: Int {
        return "\(category) \(local)".hashValue;
    }
    
    init(local:String, category : String)
    {
        self.category = category
        self.local = local
        chunk = LocalRequest(local: local, category: category)
        data = []
        maxsize = -1;
        dirty = false;
    }
    func isfull() -> Bool{
        if maxsize < chunk.requestIdx
        {
            return true
        }
        else
        {
            return false
        }
    }
    func isEnd(idx:Int) -> Bool
    {
        if maxsize == -1
        {
            return false
        }
        if idx * chunk.incSize > maxsize
        {
            return true
        }
        else
        {
            return false
        }
    }
    func have(idx:Int) -> Bool
    {
        if idx * chunk.incSize < chunk.requestIdx
        {
            return true
        }
        else
        {
            return false
        }
    }

    func getData(idx:Int) ->[SemiDetail]?{
        var result : [SemiDetail] = []
        let start = idx * chunk.incSize
        let end = (idx + 1) * chunk.incSize
        if !have(idx)
        {
            return nil
        }
        for(var i = start; i < end && i < maxsize ; i++)
        {
            result.append(data[i])
        }
        return result
    }
    
   
}


func ==(l: Local, r: Local) -> Bool {
    return (l.category==r.category) && (l.local == r.local)
}
