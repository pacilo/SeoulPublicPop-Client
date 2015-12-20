//
//  ThumbnailListViewController.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 20..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

class ThumbnailListViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {

    @IBOutlet var carousel: iCarousel!
    var items: [SemiDetail] = [] ;
    var wrap: Bool = true
    
    var categoryType: String!
    var locationName: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataCenter.getInstance().getData(locationName, category: categoryType, idx: 0, callback: {(data: [SemiDetail]) -> () in
            self.items = data
            
        })
        sleep(2)
        // Do any additional setup after loading the view.
        carousel.type = .CoverFlow2
        
        for(var i = 0; i < self.items.count ; i++)
        {
            self.carousel.insertItemAtIndex(i, animated: true)
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "detailViewCall")
        carousel.addGestureRecognizer(tapRecognizer)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // 이곳에 디테일뷰로 넘겨줄 정보를 정의해야함!
    }
    
    func detailViewCall() {
        if (true/* priority key identifier */) {
            print("SEGUE!")
            self.performSegueWithIdentifier("SegueOfDetailView", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return items.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        var itemView: UIImageView!
        
        if (view == nil) {
            // 이부분에서 이미지 쓰지말고 임의의 UIView 컨버팅해서 가져와야됨
            let my = ThumbnailCardView(frame: CGRectMake(0, 0, 300, 500))
            my.locationName.text = items[index].title
            my.locationAddress.text = items[index].address
            
            UIGraphicsBeginImageContext(my.view.bounds.size);
            my.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let screenShot = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

            itemView.image = screenShot
            itemView.layer.masksToBounds = false
            itemView.layer.shadowOffset = CGSizeMake(-15, 20)
            itemView.layer.shadowRadius = 5
            itemView.layer.shadowOpacity = 0.5
            
            itemView.contentMode = .Center
            itemView.image = screenShot;
        }
        else {
            itemView = view as! UIImageView
            //label = itemView.viewWithTag(1) as! UILabel!
        }
        return itemView
    }

    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .Spacing) {
            return value * 1.1
        }
        return value
    }


}
