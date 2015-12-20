//
//  DataCenter.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 19..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

class DataCenter {
    static private var center:DataCenter = DataCenter()
    static func getInstance()->DataCenter { return center }
    
    var sectors : [Sector : Sector ]
    var locals  : [ String : [ String : Local]]
    
    private init(){
        sectors = [:]
        locals = [:]
        
        dummy()
    }
    func dummy()
    {
        var result:[SemiDetail] = []
        
        result.append(SemiDetail.dummy())
        result.append(SemiDetail.dummy())
        result.append(SemiDetail.dummy())
        result.append(SemiDetail.dummy())
        
        let dummylocal = Local(local : "동작구", category:  "체육시설")
        dummylocal.dirty = false
        dummylocal.data = result
        
        
        locals["동작구"] = [:]
        locals["동작구"]!["체육시설"] = dummylocal
    }
    /*
        데이터를 불러온다.
        만약 데이터가 로컬에 없으면 서버에 요청해서 불러온다.
    */
    func getData(local:String, category : String, idx:Int ,callback : (data : [SemiDetail])->()) -> Bool
    {
        if locals[category] == nil
        {
            locals[category] = [:]
        }
        if locals[category]![local] == nil
        {
            let newlocal = Local(local:local,category:category)
            locals[category]![local] = newlocal
        }
        if let mylocal = locals[category]?[local]
        {
            if mylocal.isEnd(idx)
            {
                return false
            }
            if mylocal.have(idx)
            {
                callback(data: mylocal.getData(idx)!)
                return true
            }
            
            let loader = DataLoader()
        
            while( mylocal.dirty ) { }
            mylocal.dirty = true;
            
            loader.Start(mylocal.chunk,callBack: {(data : AnyObject) -> () in
                mylocal.chunk.post()
                mylocal.dirty = false
                mylocal.maxsize = data["SIZE"] as! Int;
                let list = data["SEMIS"]!
                mylocal.data.appendContentsOf(SemiDetail.makeSemiList(list! as AnyObject))
                callback(data: mylocal.getData(idx)!)
            })
            return true
        }
        print("도달불가")
        return false
    }
    func getData(category : String,callback : (data : [SemiDetail])->()) -> Bool
    {
        let loader = DataLoader()
        
        loader.Start(SectorRequest(x: 0, y: 0, category: category), callBack:  {(data:AnyObject)->() in
            callback(data: SemiDetail.makeSemiList(data["LIST"]!! as AnyObject))
        })
        return true
    }
    func getData(idx : Int,category : String) -> Detail
    {
        var result:Detail? = nil
        
        let loader = DataLoader()
        
        loader.Start(DetailRequest(id: idx,category:category), callBack:  {(data:AnyObject)->() in
            result = Detail(ResData: data)
        })
        while(result != nil) {}
        return result!
    }
    
    func getDataFromServer(local:String, category : String, callback : (data:AnyObject)->())
    {
        /*
        let loader = DataLoader()
        if let chunk = localchunks[category]![local]
        {
            loader.Start(chunk, callBack: callback)
        }
        else
        {
            loader.Start(LocalRequest(local: local, category: category),
                callBack: callback)
        }
        */
    }
    func getDataFromServer(sector:Sector, callback : (data:AnyObject)->())
    {
    /*    let loader = DataLoader()
        if let chunk = sectorchunks[sector]
        {
            loader.Start(chunk, callBack: callback)
        }
        else
        {
            //loader.Start(LocalRequest(local: local, category: category),
             //   callBack: callback)
        }
      */
    }
}