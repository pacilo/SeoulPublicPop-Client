//
//  Sector.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 20..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

struct Sector : Hashable
{
    var x,y :Int;
    var category : String;
    
    var chunk : RequestChunk;
    var data : [SemiDetail];
    var maxsize : Int;
    
    var dirty : Bool;
    
    
    var hashValue: Int {
        return "\(category) \(x) \(y)".hashValue;
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
}

func ==(l: Sector, r: Sector) -> Bool {
    return (l.x==r.x) && (l.y == r.y) && (l.category == r.category);
}
