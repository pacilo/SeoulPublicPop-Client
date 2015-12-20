//
//  PPMapIcon.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 10. 30..
//  Copyright © 2015년 DAYEONSSI. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class PPMapAnnotation : NSObject, MKAnnotation {
    var coordinate : CLLocationCoordinate2D
    var title : String?
    var realtitle : String?
    var subtitle : String?
    var category : String?
    var id : String?
    
    var child : [String:PPMapAnnotation]
    var ischild : Bool
    var myview : PPMapAnnotationView?
    
    init(coordinate : CLLocationCoordinate2D, title:String, subtitle:String, category : String, id : String)
    {
        self.coordinate = coordinate
        self.realtitle = title
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.id = id
        
        self.child = [:]
        self.ischild = false
    }
    func SetView(v : PPMapAnnotationView)
    {
        myview = v
    }
    func releaseAnnotation(mapView : MKMapView , span : MKCoordinateSpan)
    {
        var removeId = [String]()
        for a in child
        {
            if !canBeChild(a.1,_span : span)
            {
                a.1.ischild = false
                a.1.releaseAnnotation(mapView, span: span)
                mapView.addAnnotation(a.1)
                removeId.append(a.0)
            }
        }
        for id in removeId
        {
            child.removeValueForKey(id)
        }
        if let v = myview
        {
            v.countlabel!.text = String(getMyCount())
        }
         title = realtitle! + "... 외 " + String(getMyCount())
        if child.count == 0
        {
            title = realtitle
        }
    }
    func addChildAnnotation(c : PPMapAnnotation )
    {
        c.ischild = true
        c.myview = nil
        child[c.id!] = c
        if let v = myview
        {
            v.countlabel!.text = String(getMyCount())
        }
        title = realtitle! + "... 외 " + String(getMyCount())
    }
    func getMyCount() -> Int
    {
        var result : Int = 0
        if child.count == 0
        {
            return 1
        }
            
        
        for c in child
        {
            result += c.1.getMyCount()
        }
        return result + 1
    }
    func canBeChild(c : PPMapAnnotation,  _span : MKCoordinateSpan) -> Bool
    {
        if fabs(c.coordinate.longitude - coordinate.longitude) < _span.longitudeDelta/10 &&
            fabs(c.coordinate.latitude - coordinate.latitude) < _span.latitudeDelta/10
        {
            return true
        }
        return false
    }
}