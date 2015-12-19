//
//  RequestChunk.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 19..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

class RequestChunk {
    var requestMethod:String = ""
    var requestIdx:Int = 0
    var requestForm:[String:String] {
        var result : [String:String] = [:];
        result["method"]    = requestMethod;
        result["idx"]       = String(requestIdx);
        
        return result
    }
    var incSize : Int = 0
    
    init(method : String, idx : Int, incSize : Int)
    {
        self.requestMethod = method
        self.requestIdx = idx
        self.incSize = incSize
    }
    func post(){
        requestIdx += incSize
    }
}

class LocalRequest : RequestChunk{
    var local : String
    var category : String
    
    /*
        requestForm <- 리퀘스트 형태로 변형해준다.
    */
    override var requestForm : [String:String] {
        var result = super.requestForm
        
        result["local"]     = local;
        result["category"]  = category;
        
        return result
    }
    init(local : String, category : String, idx : Int = 0, incSize :Int = 20)
    {
        self.local = local
        self.category = category
        super.init(method: "local",idx: idx,incSize: incSize)
    }
}