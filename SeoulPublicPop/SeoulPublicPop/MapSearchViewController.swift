//
//  MapSearchViewController.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 17..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

class MapSearchViewController: UIViewController {

    var categoryType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("This is Map Search")
        print(categoryType)
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
