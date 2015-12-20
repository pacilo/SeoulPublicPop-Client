//
//  SectorPyramid.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 20..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation

class SectorPyramid
{
    func getSectors( edge:[(lat:Double,lon:Double)])
    {
       // var cha = edge[0].
        
    }
    func getSectorSize(let size: Int) -> Int
    {
        var s = size
        var result = 1;
        
        while(s == 0)
        {
            s /= 2
            result *= 2
        }
        return result
    }
}
/*
    SectorLayer는 sector들을 담는 일종의 컨테이너이다.
    update의 단위가 되며 요청의 크기는 사용자의 z값(span값)에 의존하게 된다.
    SectorLayer는 직접적인 정보를 가지고 있지 않고 오직 업데이트 됐는지 안됐는지에 관한 정보만 들어있다.
    이 모든 객체들은 최초 생성시에 만들어 지지는 않고 필요할 때 생성된다.
    가장 큰 레이어는 32,768 * 32,768이다.
    이 레이어에 관한 정보들은 category별로 만들어지게 된다.
    index는 32,768 * 32,768보다 큰 값을 가질 수 없다.
*/
class SectorLayer
{
    let INDEX_MAX = 32768
    var layerSize: Int;
    var layerPos:(x:Int,y:Int);
    var dataValidity:Bool = false;
    private var mylayers:[SectorLayer?]
    
    init(layerSize: Int, x:Int, y:Int)
    {
        layerPos = (x,y)
        self.layerSize = layerSize;
        dataValidity = false
        mylayers = [nil,nil,nil,nil]
    }
    
    func getInvalidSectors(x:Int,y:Int, size:Int) -> [Sector]?
    {
        if size > layerSize / 2
        {
            return getInvalidSectors()
        }
        else
        {
            return getLayer(x,y:y).getInvalidSectors(x, y: y, size: size)
        }
    }
    private func getInvalidSectors() -> [Sector]?
    {
        var result:[Sector] = []
        for(var i = 0;i<4;i++)
        {
            let x = layerPos.x + layerSize * (i/2)
            let y = layerPos.y + layerSize * (i%2)
            
            if mylayers[i] == nil || !mylayers[i]!.dataValidity
            {
                for(var j = x; j < x+layerSize / 2 ;j++)
                {
                    for(var k = y; k < y + layerSize/2 ; k++)
                    {
                        result.append(Sector(x:j,y:k))
                    }
                }
            }
        }
        return result
    }
    
    func getLayer(x:Int,y:Int) -> SectorLayer
    {
        let locax = (x - layerPos.x)/layerSize/2
        let locay = (y - layerPos.y)/layerSize/2
        
        if mylayers[locax*2 + locay] == nil
        {
            mylayers[locax*2 + locay] = SectorLayer(layerSize: layerSize/2, x: x, y: y)
        }
        
        return mylayers[locax*2 + locay]!
    }
}