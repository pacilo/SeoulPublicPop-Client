//
//  DetailView.swift
//  SeoulPublicPop-Client
//
//  Created by 최윤호 on 2015. 12. 21..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//
import MapKit
import UIKit
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            print("예약!")
        }
    }
    
}