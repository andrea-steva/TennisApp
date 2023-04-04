//
//  Extension.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

// MARK: CGRect

extension CGRect {
    
    /// The CGRect center
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

// MARK: CGSize

extension CGSize {
    
    /**
     Change an existing CGSize by a width delta and a height delta.
     
     - parameter dw: width delta
     - parameter dh: height delta
     
     - returns: The new CGSize
     */
    func sizeByDelta(deltaWidth: CGFloat, deltaHeight: CGFloat) -> CGSize {
        return CGSize(width: self.width + deltaWidth, height: self.height + deltaHeight)
    }
}

// MARK: CollectionView

extension UICollectionView {
    
    /**
     Get the indexPath for the collectionView with only a cell displayed
     
     - returns: The indexPath
     */
    func getVisibleIndexPath() -> IndexPath? {
        let visibleRect = CGRect(x: self.contentOffset.x,
                                 y: self.contentOffset.y,
                                 width: self.bounds.size.width,
                                 height: self.bounds.size.height)
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        var visibleIndexPath = self.indexPathForItem(at: visiblePoint)
        if visibleIndexPath == nil {
            let cells = self.visibleCells
            if !cells.isEmpty {
                visibleIndexPath = self.indexPath(for: cells[0])! as IndexPath
            }
        }
        return visibleIndexPath
    }
}

extension UIBarButtonItem {
    
    convenience init(iconName: String, selector: Selector, target: Any) {
        var icon = UIImage(systemName: iconName)!
        icon = icon.tint(TennisApp.Style.Colors.primaryColor)

        self.init(image: icon,
                  style: UIBarButtonItem.Style.plain,
                  target: target, action: selector)
    }
    
    static func negativeSpacer(_ width: CGFloat) -> UIBarButtonItem {
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = width >= 0 ? -width : width
        return spacer
    }
}
