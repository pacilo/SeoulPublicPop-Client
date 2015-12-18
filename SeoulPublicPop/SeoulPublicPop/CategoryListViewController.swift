//
//  CategoryListViewController.swift
//  SeoulPublicPop
//  Modified by pacilo on 2015. 11. 26..
//
//  Created by Mic Pringle on 27/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CategoryCell"

class CategoryListViewController: UICollectionViewController {

    let categoryList = CategoryList.allCategory()
    
    // let categoryListLayout: CategoryListLayoutDraw = CategoryListLayoutDraw()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let indexPath = collectionView!.indexPathForCell(sender as! CategoryListViewCell)
        let tabBarController = segue.destinationViewController as! UITabBarController
        let localSearchController = tabBarController.viewControllers![0] as! LocalSearchViewController
        let mapSearchController = tabBarController.viewControllers![1] as! MapSearchViewController
        localSearchController.categoryType = categoryList[indexPath!.item % categoryList.count].title
        mapSearchController.categoryType = categoryList[indexPath!.item % categoryList.count].title
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryList.count * 2
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CategoryListViewCell
        
        // Configure the cell
        cell.categoryList = categoryList[indexPath.item % categoryList.count]
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

/*
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    float contentOffsetWhenFullyScrolledRight = self.collectionView.frame.size.width * ([self.dataArray count] -1);

    
        let reDrawMarginOfElement: CGFloat = CGFloat((categoryList.count - (categoryList.count / 3) - 2) * 180)
        let contentOffsetWhenFullyScrolledBottom = self.collectionView!.frame.size.height +  reDrawMarginOfElement
        
        if (scrollView.contentOffset.y >= contentOffsetWhenFullyScrolledBottom) {
            let newIndex = Int(scrollView.contentOffset.y / 180) % categoryList.count
            let newIndexPath = NSIndexPath(forItem: newIndex, inSection: 0)
            print(categoryList[newIndexPath.row].title) // TESTCODE
            self.collectionView!.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
        }
        else if (scrollView.contentOffset.y == 0) {
            let newIndex = Int(scrollView.contentOffset.y / 180) % categoryList.count
            let newIndexPath = NSIndexPath(forItem: newIndex, inSection: 0)
            self.collectionView!.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: false)
        }
    }
*/    
}
