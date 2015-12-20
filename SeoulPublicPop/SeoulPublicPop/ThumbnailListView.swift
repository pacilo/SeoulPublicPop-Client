//
//  ThumbnailListView.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 21..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

@IBDesignable class ThumbnailListView: UIView {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var thumbnailInfoTable: UITableView!
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.backgroundColor = UIColor.blueColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ThumbnailCard", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
    }

}
