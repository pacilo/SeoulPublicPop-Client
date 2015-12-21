//
//  DetailView.swift
//  SeoulPublicPop-Client
//
//  Created by 최윤호 on 2015. 12. 21..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//
import MapKit
import UIKit
import Foundation

class sm : NSObject, MKAnnotation
{
    var coordinate : CLLocationCoordinate2D
    var title : String?
    var realtitle : String?
    
    init(lat : Double, lon : Double)
    {
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
class DetailViewController : UITableViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var caLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var PlaceLabel:UILabel!
    @IBOutlet weak var PayatLabel:UILabel!
    @IBOutlet weak var recpLabel:UILabel!
    @IBOutlet weak var addressLabel:UILabel!
    @IBOutlet weak var telLabel:UILabel!
    @IBOutlet weak var internetLabel:UILabel!
    
    var data : Detail!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        caLabel.text    = data.category
        titleLabel.text = data.title
        PlaceLabel.text = data.place
        PayatLabel.text = data.payat
        recpLabel.text  = data.recp
        addressLabel.text = data.address
        telLabel.text = data.tel
        
        mapView.rotateEnabled = false
        mapView.zoomEnabled     = false
        mapView.scrollEnabled = false
        mapView.pitchEnabled = false
        
        let span = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0.005)
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  data.lat, longitude: data.lon), span: span)
        let anno = sm(lat: data.lat, lon: data.lon)
        mapView.addAnnotation(anno)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0
        {
            print("지도찡호출")
        }
        if indexPath.row == 8
        {
            UIApplication.sharedApplication().openURL(NSURL(string: data.internet)!)
        }
    }
    
}