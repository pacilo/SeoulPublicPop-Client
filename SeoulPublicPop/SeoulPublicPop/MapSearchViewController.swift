//
//  MapSearchViewController.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 17..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class MapSearchViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView :MKMapView!
    var categoryType: String!
    let locationManager = CLLocationManager()
    var annotationDic : [String:PPMapAnnotation] = [:]
    var arrayForSegue:[SemiDetail] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        print("This is Map Search")
       print(categoryType)
          mapView.rotateEnabled = false
          mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  37.496324, longitude: 126.956879), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
          mapView.delegate = self
       
        //self.locationManager.delegate = self
        //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //self.locationManager.requestWhenInUseAuthorization()
        //self.locationManager.startUpdatingLocation()
       
        //self.mapView.showsUserLocation = true
        
        test()
    }
    func test()
    {
        DataCenter.getInstance().getData(categoryType) { (data) -> () in
            
            for d in data
            {
                let coordinate = CLLocationCoordinate2DMake(d.realpos.lat, d.realpos.lon)
                let title = d.title
                let category = d.category
                let subtitle = d.address
                let annotation = PPMapAnnotation(coordinate: coordinate, title: title, subtitle: subtitle,category : category, id: String(d.idx), sd : d)
                self.annotationDic[String(d.idx)] = annotation
                self.mapView.addAnnotation(annotation)
                
            }
        }

    }
    /*
    func test()
    {
    var num = 0;
    while (DataCenter.getInstance().getData("동작구", category: "다목적실", idx: num++, callback: {(data : [SemiDetail])->() in
    print("data!!!")
    }))
    {
    print("hello")
    }
    //    DataCenter.getInstance().getData("동작구")
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error: " + error.localizedDescription, terminator: "")
    }
    
   

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "MapSegue" {
            let thumbnailViewController = segue.destinationViewController as! ThumbnailListViewController
            thumbnailViewController.items = arrayForSegue
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

/*

MapView의 기능을 정의하는 부분
해당 정보에 대해서 모든 정보가 로딩 됐을 때 이 함수를 콜벡으로 호출하게 된다.
*/
extension MapSearchViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = PPMapAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
        annotationView.canShowCallout = true
        
        let calloutButton = UIButton(type: UIButtonType.DetailDisclosure)
        annotationView.rightCalloutAccessoryView = calloutButton
        
        (annotation as! PPMapAnnotation).myview = annotationView
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.region.span)
        if mapView.region.span.latitudeDelta > 0.14
        {
            var temp:MKCoordinateRegion = mapView.region
            temp.span.latitudeDelta = 0.14
            temp.span.longitudeDelta = 0.12
            mapView.region = temp
        }
       for anno in mapView.annotationsInMapRect(mapView.visibleMapRect)
        {
            if anno is PPMapAnnotation
            {
                let a = anno as! PPMapAnnotation
               //mapView.
                if a.ischild == false
                {
                    //      var tempArr = [MKAnnotation]()
                    for c in mapView.annotationsInMapRect(mapView.visibleMapRect)
                    {
                        if c is PPMapAnnotation
                        {
                            if a != c as! PPMapAnnotation
                            {
                                let child = c as! PPMapAnnotation
                                if a.canBeChild(child, _span: mapView.region.span)
                                {
                                    a.addChildAnnotation(child)
                                    mapView.removeAnnotation(c as! PPMapAnnotation)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        for anno in mapView.annotations
        {
            if anno is PPMapAnnotation
            {
                let a  = anno as! PPMapAnnotation
                a.releaseAnnotation(mapView, span: mapView.region.span)
            }
        }
    }
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        //get tag here
        /*  if(annotationView.tag == 0){
        //Do for 0 pin
        }
        */
        if control == annotationView.rightCalloutAccessoryView {
            
            let anno = annotationView.annotation as! PPMapAnnotation
            arrayForSegue = []
            for i in anno.getChildList()
            {
                arrayForSegue.append(i.data)
            }
            performSegueWithIdentifier("MapSegue", sender: self)

            /*
            let alert  = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
        }
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        //     mapView.region.
    }
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
}
