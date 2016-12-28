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
import SCLAlertView

private extension Selector {
    static let didTapOnButtonMenu = #selector(BaseViewController.didTapOnButtonMenu(_:))
}

class BaseViewController: UIViewController, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {

    // MARK: IBOutlet
    @IBOutlet var backgroundView: UIImageView?

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        if let backgroundView = self.backgroundView {
            backgroundView.image =  backgroundView.image?.applyMenuEffect()
        }

        self.title = localizer.get(controllerTitleKey())

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if hasMenuButton() {
            if self.navigationItem.leftBarButtonItems == nil {
                self.navigationItem.leftBarButtonItems = [UIBarButtonItem]()
            }
            self.navigationItem.leftBarButtonItems?.insert(self.getBarButtonItem(FontAwesome.bars, selector: .didTapOnButtonMenu), at: 0)
        }
    }

    // MARK: Controller title

    /**
    Get title localized key
    
    - returns: The localized key for the view controller title
    */
    func controllerTitleKey() -> LocalizerKey {
        return LocalizerKey.appName
    }

    // MARK: Menu Management

    @IBAction func didTapOnButtonMenu(_ sender: UIBarButtonItem) {
        self.presentLeftMenuViewController(sender)
    }

    func hasMenuButton() -> Bool {
        return true
    }

    // MARK: DZNEmptyDataSetSource

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: localizer.get( .generic_emptyDataSetTitle))
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return Style.Images.notAvailable
    }

    func offset(forEmptyDataSet scrollView: UIScrollView!) -> CGPoint {
        return CGPoint(x: 0, y: -64)
    }

    // MARK: DZNEmptyDataSetDelegate

    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSetShouldShow(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }

    // MARK: PullToRefresh & InfiniteIndicator

    func addPullToRefresh(_ scrollView: UIScrollView, completionBlock : @escaping () -> Void) {

        scrollView.ins_addPullToRefresh(withHeight: 60.0) { (scrollView) in
            completionBlock()
        }

        scrollView.ins_pullToRefreshBackgroundView.preserveContentInset = false

        //let pullToRefresh = SHPullToRefresh(frame: CGRectMake(0, 0, 40, 40))
        //scrollView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh
        //scrollView.ins_pullToRefreshBackgroundView.addSubview(pullToRefresh)
    }

    func addInfiniteIndicator(_ scrollView: UIScrollView, completionBlock : @escaping () -> Void) {

        scrollView.ins_addInfinityScroll(withHeight: 60.0) { (scrollView) in
            completionBlock()
            //scrollView.ins_endPullToRefresh()
            //scrollView.ins_endInfinityScrollWithStoppingContentOffset(true)
        }
        scrollView.ins_infiniteScrollBackgroundView.preserveContentInset = false
    }

    // MARK: View Controller Utils

    /**
    Get margin from top considering status bar and navigation bar.
    
    - returns: top margin
    */
    func getMarginFromTop() -> CGFloat {
        var margin = UIApplication.shared.statusBarFrame.size.height
        if let navigationBarHeight = navigationController?.navigationBar.frame.height {
            margin += navigationBarHeight
        }
        return margin
    }

    func getBarButtonItem(_ icon: FontAwesome, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage.fontAwesomeIcon(name: icon, textColor: Style.Colors.primaryColor, size : CGSize(width: 32, height: 32)),
                               style: UIBarButtonItemStyle.plain,
                               target: self, action: selector)
    }

    // MARK: Navigation Bar Utils

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

    // MARK: Status Bar

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    deinit {
        Log.verbose("Deinit \(self)")
    }
}
