//
//  LocalSearchViewController.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 17..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

class LocalSearchViewController: UIViewController {
    
    let locationInfoList = LocationInfoList.getLocationInfo()
    
    @IBOutlet weak var localImage: UIImageView!
    var categoryType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // loadTest()
    }
    
    func loadTest() {
        print("This is Local Search: \(categoryType)\n")
        
        for info in locationInfoList {
            let getData = info
            print(getData.localName)
            
            for position in getData.coordinates {
                let coorX: Float = position["x"] as! Float
                let coorY: Float = position["y"] as! Float
                print("X: \(coorX), Y: \(coorY)")
            }
            print("")
        }
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
        // print("TouchPosition: \(realPosition)")
        
        // do sth...
        if let resultName = touchedPositionWasInsideCheck(realPosition) {
            print(resultName)
            return
        }
        print("Fail")
    }

    func touchedPositionWasInsideCheck(position: CGPoint) -> String? {
        var coordinateX: CGFloat
        var coordinateY: CGFloat
        
        for locationInfo in locationInfoList {
            let elemCount = locationInfo.coordinates.count
            var foundFlag = true
            
            for (var index = 0; index < elemCount; index++) {
                coordinateX = CGFloat((locationInfo.coordinates)[index]["x"] as! Float)
                coordinateY = CGFloat((locationInfo.coordinates)[index]["y"] as! Float)
                let p1: CGPoint = CGPointMake(coordinateX, coordinateY)
                
                coordinateX = CGFloat((locationInfo.coordinates)[(index + 1) % elemCount]["x"] as! Float)
                coordinateY = CGFloat((locationInfo.coordinates)[(index + 1) % elemCount]["y"] as! Float)
                let p2: CGPoint = CGPointMake(coordinateX, coordinateY)
                
                if grahamScan(p1, p2: p2, p3: position) > 0 {
                    foundFlag = false
                    break // current location did not same. find next one.
                }
            }
            if foundFlag == true {
                return locationInfo.localName // same location found!
            }
        }
        return nil // cannot found any same location
    }
    
    func grahamScan(p1: CGPoint, p2: CGPoint, p3: CGPoint) -> Float {
        // "reversed counter-clockwise method"
        // If the result value was minus,
        // that mean is point(p3) located in the right-side from the line(p1~p2)
        let value1 = (p2.x - p1.x) * (p3.y - p1.y)
        let value2 = (p2.y - p1.y) * (p3.x - p1.x)
        return Float(value1 - value2)
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
