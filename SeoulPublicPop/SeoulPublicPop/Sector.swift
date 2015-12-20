//
//  Sector.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 20..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

class Sector : Hashable
{
    var x,y :Int;
    
    var chunk : RequestChunk;
    var data : [SemiDetail];
    var maxsize : Int;
    
    var dirty : Bool;
    
    
    var hashValue: Int {
        return "\(x) \(y)".hashValue;
    }
    
    init(x:Int,y:Int)
    {
         self.x = x
        self.y = y
     //   chunk = LocalRequest(local: x, category: category)
        chunk = RequestChunk(method: "tet",idx:0,incSize: 0)
        data = []
        maxsize = -1;
        dirty = false;
    }
    
    
    func isfull() -> Bool{
        if maxsize < chunk.incSize
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
    func isEnd(idx:Int) -> Bool
    {
        if idx * chunk.incSize > maxsize
        {
            return true
        }
        else
        {
            return false
        }
    }
    func addList(obj : AnyObject)
    {
        var num = 0;
        while(num < obj.count)
        {
            if let newsemi = obj[num++]
            {
                data.append(SemiDetail(ResData: newsemi))
            }
            else
            {
                break;
            }
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

func ==(l: Sector, r: Sector) -> Bool {
    return (l.x==r.x) && (l.y == r.y);
}
