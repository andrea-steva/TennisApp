//
//  Extension.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import FontAwesome_swift
import RealmSwift
import UIKit

// MARK: - UIViewController

extension UIViewController {
    
    class func instantiateFromStoryboard<T: UIViewController>(_ storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}

// MARK: UIColor

extension UIColor {
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Init color starting from its RGBA representation
     
     :param: rgba
     
     :returns: UIColor instance
     */
    convenience init(rgba: UInt) {
        let sRgba = min(rgba, 0xFFFFFFFF)
        let red: CGFloat = CGFloat((sRgba & 0xFF000000) >> 24) / 255.0
        let green: CGFloat = CGFloat((sRgba & 0x00FF0000) >> 16) / 255.0
        let blue: CGFloat = CGFloat((sRgba & 0x0000FF00) >> 8) / 255.0
        let alpha: CGFloat = CGFloat(sRgba & 0x000000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Init color starting from its HEX representation
     
     :param: hex on RGBA format
     
     :returns: UIColor instance
     */
    convenience init(hexRgba: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let index   = hexRgba.hasPrefix("#") ? hexRgba.characters.index(after: hexRgba.startIndex) : hexRgba.startIndex
        
        let hex     = hexRgba.substring(from: index)
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch hex.characters.count {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
            }
        } else {
            print("Scan hex error")
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func lighter(_ amount: CGFloat = 0.25) -> UIColor {
        return hueColorWithBrightnessAmount(1 + amount)
    }
    
    func darker(_ amount: CGFloat = 0.25) -> UIColor {
        return hueColorWithBrightnessAmount(1 - amount)
    }
    
    fileprivate func hueColorWithBrightnessAmount(_ amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor( hue: hue,
                            saturation: saturation,
                            brightness: brightness * amount,
                            alpha: alpha )
        } else {
            return self
        }
    }
    
}

// MARK: UIImage

extension UIImage {
    
    class func imageWithColor(_ color: UIColor) -> UIImage {
        return UIImage.imageWithColor(color, circular: false)
    }
    
    class func imageWithColor(_ color: UIColor, circular: Bool) -> UIImage {
        let size: CGFloat = circular ? 100 : 1
        let rect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        if circular {
            context!.fillEllipse(in: rect)
        } else {
            context!.fill(rect)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    // colorize image with given tint color
    // this is similar to Photoshop's "Color" layer blend mode
    // this is perfect for non-greyscale source images, and images that have both highlights and shadows that should be preserved
    // white will stay white and black will stay black as the lightness of the image is preserved
    func tint(_ tintColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            context.setBlendMode(.normal)
            UIColor.black.setFill()
            context.fill(rect)
            
            // draw original image
            context.setBlendMode(.normal)
            context.draw(self.cgImage!, in: rect)
            
            // tint image (loosing alpha) - the luminosity of the original image is preserved
            context.setBlendMode(.color)
            tintColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
    
    // fills the alpha channel of the source image with the given color
    // any color information except to the alpha channel will be ignored
    func fillAlpha(_ fillColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw tint color
            context.setBlendMode(.normal)
            fillColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
    
    fileprivate func modifiedImage(_ draw: (CGContext, CGRect) -> Void) -> UIImage {
        
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

// MARK: String

extension String {
    
    mutating func replace(targetString target: String, withString replacingString: String) {
        self = self.replacingOccurrences(of: target, with: replacingString)
    }
}

// MARK: UITableViewCell

public extension UITableViewCell {
    func removeMargins() {
        
        if self.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            self.separatorInset = UIEdgeInsets.zero
        }
        
        if self.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            self.preservesSuperviewLayoutMargins = false
        }
        
        if self.responds(to: #selector(setter: UIView.layoutMargins)) {
            self.layoutMargins = UIEdgeInsets.zero
        }
    }
}

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

// MARK: NSLayoutConstraint

extension NSLayoutConstraint {
    
    class func reportAmbiguity (_ aView: UIView?) {
        var v = aView
        if v == nil {
            v = UIApplication.shared.keyWindow
        }
        for vv in v!.subviews {
            print("\(vv) \(vv.hasAmbiguousLayout)")
            if !vv.subviews.isEmpty {
                self.reportAmbiguity(vv)
            }
        }
    }
    class func listConstraints (_ aView: UIView?) {
        var v = aView
        if v == nil {
            v = UIApplication.shared.keyWindow
        }
        for vv in v!.subviews {
            let arr1 = vv.constraintsAffectingLayout(for: .horizontal)
            let arr2 = vv.constraintsAffectingLayout(for: .vertical)
            NSLog("\n\n%@\nH: %@\nV:%@", vv, arr1, arr2)
            if !vv.subviews.isEmpty {
                self.listConstraints(vv)
            }
        }
    }
}

// MARK: Array

extension Array {
    
    /**
     Remove objects for the indexes
     
     - parameter ixs: The indexes for the objects to remove
     */
    mutating func removeAtIndexes (_ ixs: [Int]) -> Void {
        for i in ixs.sorted(by: >) {
            self.remove(at: i)
        }
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
    
    convenience init(icon: FontAwesome, selector: Selector, target: Any) {
        self.init(image: UIImage.fontAwesomeIcon(name: icon, textColor: TennisApp.Style.Colors.primaryColor, size: CGSize(width: 32, height: 32)),
                  style: UIBarButtonItemStyle.plain,
                  target: target, action: selector)
    }
    
    static func negativeSpacer(_ width: CGFloat) -> UIBarButtonItem {
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = width >= 0 ? -width : width
        return spacer
    }
}

extension UITableView {
    func applyChanges<T>(changes: RealmCollectionChange<T>) {
        switch changes {
        case .initial: reloadData()
        case .update(_, let deletions, let insertions, let updates):
            let fromRow = {(row: Int) in
                return IndexPath(row: row, section: 0)}
            
            beginUpdates()
            deleteRows(at: deletions.map(fromRow), with: .automatic)
            insertRows(at: insertions.map(fromRow), with: .automatic)
            reloadRows(at: updates.map(fromRow), with: .none)
            endUpdates()
        default: break
        }
    }
}
