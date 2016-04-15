//
//  BaseViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import FontAwesome_swift
import INSPullToRefresh

class BaseViewController: UIViewController, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, MVVMViewResource {

    //MARK: IBOutlet
    @IBOutlet var backgroundView : UIImageView?
    
    
    //MARK: View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let backgroundView = self.backgroundView {
            backgroundView.image =  backgroundView.image?.applyMenuEffect()
        }

        self.title = localizer.get(controllerTitleKey())
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        if hasMenuButton() {
            if self.navigationItem.leftBarButtonItems == nil {
                self.navigationItem.leftBarButtonItems = [UIBarButtonItem]()
            }
            self.navigationItem.leftBarButtonItems?.insert(self.getBarButtonItem(FontAwesome.Bars, selector: "didTapOnButtonMenu:"), atIndex: 0)
        }
    }
    
    //MARK: Controller title
    
    /**
    Get title localized key
    
    - returns: The localized key for the view controller title
    */
    func controllerTitleKey() -> LocalizerKey {
        return LocalizerKey.appName
    }
    

    //MARK: Menu Management
    
    @IBAction func didTapOnButtonMenu(sender : UIBarButtonItem) {
        self.presentLeftMenuViewController(sender)
    }
    
    func hasMenuButton() -> Bool {
        return true
    }
    
    //MARK: DZNEmptyDataSetSource
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: localizer.get( .generic_emptyDataSetTitle))
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return Style.Images.notAvailable
    }
    
    func offsetForEmptyDataSet(scrollView: UIScrollView!) -> CGPoint {
        return CGPointMake(0, -64)
    }

    //MARK: DZNEmptyDataSetDelegate
    
    func emptyDataSetShouldAllowTouch(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldShow(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return false
    }
    
    //MARK: PullToRefresh & InfiniteIndicator
    
    func addPullToRefresh(scrollView : UIScrollView, completionBlock : () -> Void) {
        scrollView.ins_addPullToRefreshWithHeight(60.0) { (scrollView : UIScrollView!) -> Void in
            completionBlock()
        }
        scrollView.ins_pullToRefreshBackgroundView.preserveContentInset = false
        
        //let pullToRefresh = SHPullToRefresh(frame: CGRectMake(0, 0, 40, 40))
        //scrollView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh
        //scrollView.ins_pullToRefreshBackgroundView.addSubview(pullToRefresh)
    }
    
    func addInfiniteIndicator(scrollView : UIScrollView, completionBlock : () -> Void) {
        scrollView.ins_addInfinityScrollWithHeight(60.0) { (scrollView : UIScrollView!) -> Void in
            completionBlock()
            //scrollView.ins_endPullToRefresh()
            //scrollView.ins_endInfinityScrollWithStoppingContentOffset(true)
        }
        scrollView.ins_infiniteScrollBackgroundView.preserveContentInset = false
        
        //let infinityIndicator = SHInfiniteIndicator(frame: CGRectMake(0, 0, 40, 40))
        //scrollView.ins_infiniteScrollBackgroundView.addSubview(infinityIndicator)
        //infinityIndicator.startAnimating()
    }
    
    //MARK: View Controller Utils
    
    /**
    Get margin from top considering status bar and navigation bar.
    
    - returns: top margin
    */
    func getMarginFromTop() -> CGFloat {
        var margin = UIApplication.sharedApplication().statusBarFrame.size.height
        if let navigationBarHeight = navigationController?.navigationBar.frame.height {
            margin += navigationBarHeight
        }
        return margin
    }
    
    func getBarButtonItem(icon : FontAwesome, selector : Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage.fontAwesomeIconWithName(icon, textColor: Style.Colors.primaryColor, size : CGSizeMake(32, 32)), style: UIBarButtonItemStyle.Plain, target: self, action: selector)
    }
    
    //MARK: Navigation Bar Utils
    
    /**
    Show back button
    */
    func showBackButton() {
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    /**
     Hide back button
     */
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Status Bar
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
