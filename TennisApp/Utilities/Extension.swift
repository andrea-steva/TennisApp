//
//  Extension.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit
import FormatterKit

// MARK: - Extension

private let deviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
    /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
    /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
    /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
    /* iPhone 6 */        "iPhone7,2": "iPhone 6",
    /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
    /* iPhone 6S */       "iPhone8,1": "iPhone 6S",
    /* iPhone 6S Plus */  "iPhone8,2": "iPhone 6S Plus",
    /* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
    /* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
    /* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
    /* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
    /* iPad Air 2 */      "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
    /* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
    /* iPad Mini 2 */     "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
    /* iPad Mini 3 */     "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
    /* iPad Mini 4 */     "iPad5,1": "iPad Mini", "iPad5,2": "iPad Mini",
    /* iPad Pro */        "iPad6,7": "iPad Pro", "iPad6,8": "iPad Pro",
    /* Apple TV */        "AppleTV5,3": "Apple TV",
    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]

// MARK: - UIFont

extension UIFont {
    func bold() -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [NSFontAttributeName : FontType.Bold.rawValue])
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }

    func semibold() -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [NSFontAttributeName : FontType.Semibold.rawValue])
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }

    func regular() -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [NSFontAttributeName : FontType.Regular.rawValue])
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }

    func light() -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [NSFontAttributeName : FontType.Light.rawValue])
        return UIFont(descriptor: descriptor, size: self.pointSize)
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
        let sRgba = min(rgba,0xFFFFFFFF)
        let red: CGFloat = CGFloat((sRgba & 0xFF000000) >> 24) / 255.0
        let green: CGFloat = CGFloat((sRgba & 0x00FF0000) >> 16) / 255.0
        let blue: CGFloat = CGFloat((sRgba & 0x0000FF00) >> 8) / 255.0
        let alpha: CGFloat = CGFloat(sRgba & 0x000000FF) / 255.0

        self.init(red: red, green: green, blue:blue, alpha:alpha)
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
            switch (hex.characters.count) {
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

        self.init(red:red, green:green, blue:blue, alpha:alpha)
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
        if(circular) {
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

    fileprivate func modifiedImage(_ draw: (CGContext, CGRect) -> ()) -> UIImage {

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

    var length: Int { return self.characters.count }

    mutating func replace(targetString target: String, withString replacingString: String) {
        self = self.replacingOccurrences(of: target, with: replacingString)
    }
}

// MARK: UIDevice

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

public extension UIDevice {

    static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)

        var identifier = ""

        for child in mirror.children {
            if let value = child.value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }
        return deviceList[identifier] ?? identifier
    }

    static var isIphone4: Bool {
        return modelName == "iPhone 4S" || modelName == "iPhone 4" || UIDevice.isSimulatorIPhone4
    }

    static var isIphone5: Bool {
        return modelName == "iPhone 5" || modelName == "iPhone 5C" || modelName == "iPhone 5S" || UIDevice.isSimulatorIPhone5
    }

    static var isIphone6: Bool {
        return modelName == "iPhone 6" || modelName == "iPhone 6S" || UIDevice.isSimulatorIPhone6
    }

    static var isIphone6Plus: Bool {
        return modelName == "iPhone 6 Plus" || modelName == "iPhone 6S Plus" || UIDevice.isSimulatorIPhone6Plus
    }

    static var isIpad: Bool {
        if (UIDevice.current.model.range(of: "iPad") != nil) {
            return true
        }
        return false
    }

    static var isIphone: Bool {
        return !self.isIpad
    }

    /// Check if current device is iPhone4S (and earlier) relying on screen heigth
    static var isSimulatorIPhone4: Bool {
        return UIDevice.isSimulatorWithScreenHeight(480)
    }

    /// Check if current device is iPhone5 relying on screen heigth
    static var isSimulatorIPhone5: Bool {
        return UIDevice.isSimulatorWithScreenHeight(568)
    }

    /// Check if current device is iPhone6 relying on screen heigth
    static var isSimulatorIPhone6: Bool {
        return UIDevice.isSimulatorWithScreenHeight(667)
    }

    /// Check if current device is iPhone6 Plus relying on screen heigth
    static var isSimulatorIPhone6Plus: Bool {
        return UIDevice.isSimulatorWithScreenHeight(736)
    }

    fileprivate static func isSimulatorWithScreenHeight(_ heigth: CGFloat) -> Bool {
        let screenSize: CGRect = UIScreen.main.bounds
        return modelName == "Simulator" && screenSize.height == heigth
    }

}

// MARK: UIView

extension UIView {

    enum ViewBorder: String {
        case Left = "borderLeft"
        case Right = "borderRight"
        case Top = "borderTop"
        case Bottom = "borderBottom"
    }

    /**
     Add a border to the view
     
     - parameter viewBorder: View border type
     - parameter color:      Border color
     - parameter width:      Border width
     */
    func addBorder(_ viewBorder: ViewBorder, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.name = viewBorder.rawValue
        switch viewBorder {
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .Right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        case .Top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        case .Bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        }
        self.layer.addSublayer(border)
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor?) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        self.layer.mask = mask

        if let color = borderColor?.cgColor {
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeColor = color
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 1.0
            self.layer.addSublayer(layer)
        }
    }

    class func loadFromNibNamed(_ nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    // MARK: Constraints

    func addGenericConstraint(_ innerView: UIView, attribute: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: innerView,
                                            attribute: attribute,
                                            multiplier: multiplier,
                                            constant: constant)
        self.addConstraint(constraint)
        return constraint
    }

    func addConstraintTop(_ innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.top, multiplier: multiplier, constant: constant)
    }

    func addConstraintBottom(_ innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.bottom, multiplier: multiplier, constant: constant)
    }

    func addConstraintCenterX(_ innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.centerX, multiplier: multiplier, constant: constant)
    }

    func addConstraintCenterY(_ innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.centerY, multiplier: multiplier, constant: constant)
    }

    func addConstraintLeading(_ innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.leading, multiplier: multiplier, constant: constant)
    }

    func addConstraintTrailing(_ innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.trailing, multiplier: multiplier, constant: constant)
    }

    func addConstraintWidth(_ innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        let attribute = NSLayoutAttribute.width
        let constraint = NSLayoutConstraint(item: innerView,
                                            attribute: attribute,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: nil,
                                            attribute: attribute,
                                            multiplier: multiplier,
                                            constant: constant)
        self.addConstraint(constraint)
        return constraint
    }

    func addConstraintHeight(_ innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        let attribute = NSLayoutAttribute.height
        let constraint = NSLayoutConstraint(item: innerView,
                                            attribute: attribute,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: nil,
                                            attribute: attribute,
                                            multiplier: multiplier,
                                            constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
}

// MARK: NSDate

public extension Date {

    /**
     Get string date with date formate "d MMMMM yyyy"
     
     - returns: The date in string format
     */
    func toLabel() -> String {
        let interval = -self.timeIntervalSinceNow
        if interval < 2 * 60 * 60 * 1000 {
            let formatter = TTTTimeIntervalFormatter()
            return formatter.string(forTimeInterval: interval)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMMM yyyy"
            return formatter.string(from: self)
        }
    }

    // MARK: NSDate Manipulation

    /**
    Returns a new NSDate object representing the date calculated by adding the amount specified to self date
    
    :param: seconds number of seconds to add
    :param: minutes number of minutes to add
    :param: hours number of hours to add
    :param: days number of days to add
    :param: weeks number of weeks to add
    :param: months number of months to add
    :param: years number of years to add
    :returns: the NSDate computed
    */
    public func add(_ seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        let calendar = Calendar.current

        let version = floor(NSFoundationVersionNumber)

        if version <= NSFoundationVersionNumber10_9_2 {
            var component = DateComponents()
            (component as NSDateComponents).setValue(seconds, forComponent: .second)

            var date: Date! = (calendar as NSCalendar).date(byAdding: component, to: self, options: NSCalendar.Options.wrapComponents)!
            component = DateComponents()
            (component as NSDateComponents).setValue(minutes, forComponent: .minute)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(hours, forComponent: .hour)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(days, forComponent: .day)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(weeks, forComponent: .weekOfMonth)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(months, forComponent: .month)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!

            component = DateComponents()
            (component as NSDateComponents).setValue(years, forComponent: .year)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: NSCalendar.Options.wrapComponents)!
            return date
        }

        var date: Date! = (calendar as NSCalendar).date(byAdding: .second, value: seconds, to: self, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .minute, value: minutes, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .day, value: days, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .hour, value: hours, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .weekOfMonth, value: weeks, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .month, value: months, to: date, options: NSCalendar.Options.wrapComponents)
        date = (calendar as NSCalendar).date(byAdding: .year, value: years, to: date, options: NSCalendar.Options.wrapComponents)
        return date
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
     
     :param: seconds number of seconds to add
     :returns: the NSDate computed
     */
    public func addSeconds (_ seconds: Int) -> Date {
        return add(seconds)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
     
     :param: minutes number of minutes to add
     :returns: the NSDate computed
     */
    public func addMinutes (_ minutes: Int) -> Date {
        return add(minutes: minutes)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
     
     :param: hours number of hours to add
     :returns: the NSDate computed
     */
    public func addHours(_ hours: Int) -> Date {
        return add(hours: hours)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of days to self date
     
     :param: days number of days to add
     :returns: the NSDate computed
     */
    public func addDays(_ days: Int) -> Date {
        return add(days: days)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date
     
     :param: weeks number of weeks to add
     :returns: the NSDate computed
     */
    public func addWeeks(_ weeks: Int) -> Date {
        return add(weeks: weeks)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of months to self date
     
     :param: months number of months to add
     :returns: the NSDate computed
     */

    public func addMonths(_ months: Int) -> Date {
        return add(months: months)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of years to self date
     
     :param: years number of year to add
     :returns: the NSDate computed
     */
    public func addYears(_ years: Int) -> Date {
        return add(years: years)
    }

    // MARK: Date comparison

    /**
    Checks if self is after input NSDate
    
    :param: date NSDate to compare
    :returns: True if self is after the input NSDate, false otherwise
    */
    public func isAfter(_ date: Date) -> Bool {
        return (self.compare(date) == ComparisonResult.orderedDescending)
    }

    /**
     Checks if self is before input NSDate
     
     :param: date NSDate to compare
     :returns: True if self is before the input NSDate, false otherwise
     */
    public func isBefore(_ date: Date) -> Bool {
        return (self.compare(date) == ComparisonResult.orderedAscending)
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
    mutating func removeAtIndexes (_ ixs: [Int]) -> () {
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

    static func negativeSpacer(_ width: CGFloat) -> UIBarButtonItem {

        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = width >= 0 ? -width : width
        return spacer
    }
}
