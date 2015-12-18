//
//  LocalSearchViewController.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 17..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

class LocalSearchViewController: UIViewController {
    
    @IBOutlet weak var localImage: UIImageView!
    var categoryType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("This is Local Search")
        print(categoryType)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let imageViewPoint: CGPoint = touches.first!.locationInView(localImage)
        let ratioOfPositionX = imageViewPoint.x / localImage.frame.size.width
        let ratioOfPositionY = imageViewPoint.y / localImage.frame.size.height
        let realPosition: CGPoint = CGPointMake(localImage.image!.size.width * ratioOfPositionX, localImage.image!.size.height * ratioOfPositionY)
        print("RealLocation: \(realPosition)")
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
