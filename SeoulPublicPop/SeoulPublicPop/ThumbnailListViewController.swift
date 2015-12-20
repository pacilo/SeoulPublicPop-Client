//
//  ThumbnailListViewController.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 20..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

class ThumbnailListViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    var categoryType: String?
    var locationName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        exitButton.setTitle(locationName, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
