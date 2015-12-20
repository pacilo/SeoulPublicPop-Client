//
//  ThumbnailListView.swift
//  SeoulPublicPop
//
//  Created by pacilo on 2015. 12. 21..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import UIKit

@IBDesignable class ThumbnailCardView: UIView {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var thumbnailInfoTable: UITableView!
    var view:UIView!;
    
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
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        thumbnailImage = view.subviews[0] as! UIImageView       // image : 저기안에 이미지뷰 있음.
        thumbnailInfoTable = view.subviews[1]as! UITableView    // table : 저기안에 테이블있음.
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
    }

}
