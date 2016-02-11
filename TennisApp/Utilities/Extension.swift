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

private let DeviceList = [
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
        let descriptor = UIFontDescriptor(fontAttributes: [NSFontAttributeName : FontType.BOLD.rawValue])
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }
    
    func semibold() -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [NSFontAttributeName : FontType.SEMIBOLD.rawValue])
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }
    
    func regular() -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [NSFontAttributeName : FontType.LIGHT.rawValue])
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }
    
    func light() -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [NSFontAttributeName : FontType.LIGHT.rawValue])
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
    convenience init(rgba: UInt){
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
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let index   = hexRgba.hasPrefix("#") ? hexRgba.startIndex.successor() : hexRgba.startIndex
        
        let hex     = hexRgba.substringFromIndex(index)
        let scanner = NSScanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexLongLong(&hexValue) {
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
}

// MARK: UIImage

extension UIImage {
    
    class func imageWithColor(color: UIColor) -> UIImage {
        return UIImage.imageWithColor(color, circular: false)
    }
    
    class func imageWithColor(color: UIColor, circular : Bool) -> UIImage {
        let size : CGFloat = circular ? 100 : 1;
        let rect = CGRectMake(0.0, 0.0, size, size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        if(circular) {
            CGContextFillEllipseInRect(context, rect)
        }
        else {
            CGContextFillRect(context, rect)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // colorize image with given tint color
    // this is similar to Photoshop's "Color" layer blend mode
    // this is perfect for non-greyscale source images, and images that have both highlights and shadows that should be preserved
    // white will stay white and black will stay black as the lightness of the image is preserved
    func tint(tintColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            CGContextSetBlendMode(context, .Normal)
            UIColor.blackColor().setFill()
            CGContextFillRect(context, rect)
            
            // draw original image
            CGContextSetBlendMode(context, .Normal)
            CGContextDrawImage(context, rect, self.CGImage)
            
            // tint image (loosing alpha) - the luminosity of the original image is preserved
            CGContextSetBlendMode(context, .Color)
            tintColor.setFill()
            CGContextFillRect(context, rect)
            
            // mask by alpha values of original image
            CGContextSetBlendMode(context, .DestinationIn)
            CGContextDrawImage(context, rect, self.CGImage)
        }
    }
    
    // fills the alpha channel of the source image with the given color
    // any color information except to the alpha channel will be ignored
    func fillAlpha(fillColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw tint color
            CGContextSetBlendMode(context, .Normal)
            fillColor.setFill()
            CGContextFillRect(context, rect)
            
            // mask by alpha values of original image
            CGContextSetBlendMode(context, .DestinationIn)
            CGContextDrawImage(context, rect, self.CGImage)
        }
    }
    
    private func modifiedImage(@noescape draw: (CGContext, CGRect) -> ()) -> UIImage {
        
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        // correctly rotate image
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        let rect = CGRectMake(0.0, 0.0, size.width, size.height)
        
        draw(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: String

extension String {
    
    var length: Int { return self.characters.count }
    
    func substringWithRange(start start: Int, end: Int) -> String {
        let index = self.startIndex
        return self.substringWithRange(Range<String.Index>(start: index.advancedBy(start), end: index.advancedBy(start + end)))
    }
    
    mutating func replace(targetString target: String, withString replacingString: String) {
        self = self.stringByReplacingOccurrencesOfString(target, withString: replacingString)
    }
}


// MARK: UIDevice

public extension UITableViewCell {
    func removeMargins() {
        
        if self.respondsToSelector("setSeparatorInset:") {
            self.separatorInset = UIEdgeInsetsZero
        }
        
        if self.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            self.preservesSuperviewLayoutMargins = false
        }
        
        if self.respondsToSelector("setLayoutMargins:") {
            self.layoutMargins = UIEdgeInsetsZero
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
            if let value = child.value as? Int8 where value != 0 {
                identifier.append(UnicodeScalar(UInt8(value)))
            }
        }
        return DeviceList[identifier] ?? identifier
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
        if (UIDevice.currentDevice().model.rangeOfString("iPad") != nil) {
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
    
    private static func isSimulatorWithScreenHeight(heigth: CGFloat) -> Bool {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        return modelName == "Simulator" && screenSize.height == heigth
    }
    
}

// MARK: NSRange

public extension NSRange {
    func stringRangeForText(string: String) -> Range<String.Index> {
        let start = string.startIndex.advancedBy(self.location)
        let end = start.advancedBy(self.length)
        return Range<String.Index>(start: start, end: end)
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
    func addBorder(viewBorder: ViewBorder, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.name = viewBorder.rawValue
        switch viewBorder {
        case .Left:
            border.frame = CGRectMake(0, 0, width, self.frame.size.height)
        case .Right:
            border.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height)
        case .Top:
            border.frame = CGRectMake(0, 0, self.frame.size.width, width)
        case .Bottom:
            border.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width)
        }
        self.layer.addSublayer(border)
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat, borderColor : UIColor?) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        
        self.layer.mask = mask
        
        if let color = borderColor?.CGColor {
            let layer = CAShapeLayer()
            layer.path = path.CGPath
            layer.strokeColor = color
            layer.fillColor = UIColor.clearColor().CGColor
            layer.lineWidth = 1.0
            self.layer.addSublayer(layer)
        }
    }
    
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
    
    // MARK: Constraints
    
    func addGenericConstraint(innerView: UIView, attribute: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint  {
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: NSLayoutRelation.Equal, toItem: innerView, attribute: attribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintTop(innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint  {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.Top, multiplier: multiplier, constant: constant)
    }
    
    func addConstraintBottom(innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint  {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.Bottom, multiplier: multiplier, constant: constant)
    }
    
    func addConstraintCenterX(innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint  {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.CenterX, multiplier: multiplier, constant: constant)
    }
    
    func addConstraintCenterY(innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint  {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.CenterY, multiplier: multiplier, constant: constant)
    }
    
    func addConstraintLeading(innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint  {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.Leading, multiplier: multiplier, constant: constant)
    }
    
    func addConstraintTrailing(innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return self.addGenericConstraint(innerView, attribute: NSLayoutAttribute.Trailing, multiplier: multiplier, constant: constant)
    }
    
    func addConstraintWidth(innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        let attribute = NSLayoutAttribute.Width
        let constraint = NSLayoutConstraint(item: innerView, attribute: attribute, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: attribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintHeight(innerView: UIView, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        let attribute = NSLayoutAttribute.Height
        let constraint = NSLayoutConstraint(item: innerView, attribute: attribute, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: attribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
}

// MARK: NSDate

public extension NSDate {
    
    /**
     Get string date with date formate "d MMMMM yyyy"
     
     - returns: The date in string format
     */
    func toLabel() -> String {
        let interval = -self.timeIntervalSinceNow
        if interval < 2 * 60 * 60 * 1000 {
            let formatter = TTTTimeIntervalFormatter()
            return formatter.stringForTimeInterval(interval)
        }
        else {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "d MMMMM yyyy"
            return formatter.stringFromDate(self)
        }
    }
    
    // MARK:  NSDate Manipulation
    
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
    public func add(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        
        let version = floor(NSFoundationVersionNumber)
        
        if version <= NSFoundationVersionNumber10_9_2 {
            var component = NSDateComponents()
            component.setValue(seconds, forComponent: .Second)
            
            var date : NSDate! = calendar.dateByAddingComponents(component, toDate: self, options: NSCalendarOptions.WrapComponents)!
            component = NSDateComponents()
            component.setValue(minutes, forComponent: .Minute)
            date = calendar.dateByAddingComponents(component, toDate: date, options: NSCalendarOptions.WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(hours, forComponent: .Hour)
            date = calendar.dateByAddingComponents(component, toDate: date, options: NSCalendarOptions.WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(days, forComponent: .Day)
            date = calendar.dateByAddingComponents(component, toDate: date, options: NSCalendarOptions.WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(weeks, forComponent: .WeekOfMonth)
            date = calendar.dateByAddingComponents(component, toDate: date, options: NSCalendarOptions.WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(months, forComponent: .Month)
            date = calendar.dateByAddingComponents(component, toDate: date, options: NSCalendarOptions.WrapComponents)!
            
            component = NSDateComponents()
            component.setValue(years, forComponent: .Year)
            date = calendar.dateByAddingComponents(component, toDate: date, options: NSCalendarOptions.WrapComponents)!
            return date
        }
        
        var date : NSDate! = calendar.dateByAddingUnit(.Second, value: seconds, toDate: self, options: NSCalendarOptions.WrapComponents)
        date = calendar.dateByAddingUnit(.Minute, value: minutes, toDate: date, options: NSCalendarOptions.WrapComponents)
        date = calendar.dateByAddingUnit(.Day, value: days, toDate: date, options: NSCalendarOptions.WrapComponents)
        date = calendar.dateByAddingUnit(.Hour, value: hours, toDate: date, options: NSCalendarOptions.WrapComponents)
        date = calendar.dateByAddingUnit(.WeekOfMonth, value: weeks, toDate: date, options: NSCalendarOptions.WrapComponents)
        date = calendar.dateByAddingUnit(.Month, value: months, toDate: date, options: NSCalendarOptions.WrapComponents)
        date = calendar.dateByAddingUnit(.Year, value: years, toDate: date, options: NSCalendarOptions.WrapComponents)
        return date
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
     
     :param: seconds number of seconds to add
     :returns: the NSDate computed
     */
    public func addSeconds (seconds: Int) -> NSDate {
        return add(seconds)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
     
     :param: minutes number of minutes to add
     :returns: the NSDate computed
     */
    public func addMinutes (minutes: Int) -> NSDate {
        return add(minutes: minutes)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
     
     :param: hours number of hours to add
     :returns: the NSDate computed
     */
    public func addHours(hours: Int) -> NSDate {
        return add(hours: hours)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of days to self date
     
     :param: days number of days to add
     :returns: the NSDate computed
     */
    public func addDays(days: Int) -> NSDate {
        return add(days: days)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date
     
     :param: weeks number of weeks to add
     :returns: the NSDate computed
     */
    public func addWeeks(weeks: Int) -> NSDate {
        return add(weeks: weeks)
    }
    
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of months to self date
     
     :param: months number of months to add
     :returns: the NSDate computed
     */
    
    public func addMonths(months: Int) -> NSDate {
        return add(months: months)
    }
    
    /**
     Returns a new NSDate object representing the date calculated by adding an amount of years to self date
     
     :param: years number of year to add
     :returns: the NSDate computed
     */
    public func addYears(years: Int) -> NSDate {
        return add(years: years)
    }
    
    // MARK:  Date comparison
    
    /**
    Checks if self is after input NSDate
    
    :param: date NSDate to compare
    :returns: True if self is after the input NSDate, false otherwise
    */
    public func isAfter(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedDescending)
    }
    
    /**
     Checks if self is before input NSDate
     
     :param: date NSDate to compare
     :returns: True if self is before the input NSDate, false otherwise
     */
    public func isBefore(date: NSDate) -> Bool{
        return (self.compare(date) == NSComparisonResult.OrderedAscending)
    }
    
    
    // MARK: Getter
    
    /**
    Date year
    */
    public var year : Int {
        get {
            return getComponent(.Year)
        }
    }
    
    /**
     Date month
     */
    public var month : Int {
        get {
            return getComponent(.Month)
        }
    }
    
    /**
     Date weekday
     */
    public var weekday : Int {
        get {
            return getComponent(.Weekday)
        }
    }
    
    /**
     Date weekMonth
     */
    public var weekMonth : Int {
        get {
            return getComponent(.WeekOfMonth)
        }
    }
    
    
    /**
     Date days
     */
    public var days : Int {
        get {
            return getComponent(.Day)
        }
    }
    
    /**
     Date hours
     */
    public var hours : Int {
        
        get {
            return getComponent(.Hour)
        }
    }
    
    /**
     Date minuts
     */
    public var minutes : Int {
        get {
            return getComponent(.Minute)
        }
    }
    
    /**
     Date seconds
     */
    public var seconds : Int {
        get {
            return getComponent(.Second)
        }
    }
    
    /**
     Returns the value of the NSDate component
     
     :param: component NSCalendarUnit
     :returns: the value of the component
     */
    
    public func getComponent (component : NSCalendarUnit) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(component, fromDate: self)
        
        return components.valueForComponent(component)
    }
}

// MARK: CGRect

extension CGRect {
    
    /// The CGRect center
    var center : CGPoint {
        return CGPointMake(self.midX, self.midY)
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
    func sizeByDelta(dw dw:CGFloat, dh:CGFloat) -> CGSize {
        return CGSizeMake(self.width + dw, self.height + dh)
    }
}

// MARK: NSLayoutConstraint

extension NSLayoutConstraint {
    
    class func reportAmbiguity (var v:UIView?) {
        if v == nil {
            v = UIApplication.sharedApplication().keyWindow
        }
        for vv in v!.subviews {
            print("\(vv) \(vv.hasAmbiguousLayout())")
            if vv.subviews.count > 0 {
                self.reportAmbiguity(vv)
            }
        }
    }
    class func listConstraints (var v:UIView?) {
        if v == nil {
            v = UIApplication.sharedApplication().keyWindow
        }
        for vv in v!.subviews {
            let arr1 = vv.constraintsAffectingLayoutForAxis(.Horizontal)
            let arr2 = vv.constraintsAffectingLayoutForAxis(.Vertical)
            NSLog("\n\n%@\nH: %@\nV:%@", vv, arr1, arr2)
            if vv.subviews.count > 0 {
                self.listConstraints(vv)
            }
        }
    }
}

//MARK: Array

extension Array {
    
    /**
     Remove objects for the indexes
     
     - parameter ixs: The indexes for the objects to remove
     */
    mutating func removeAtIndexes (ixs:[Int]) -> () {
        for i in ixs.sort(>) {
            self.removeAtIndex(i)
        }
    }
}

//MARK: CollectionView

extension UICollectionView {
    
    /**
     Get the indexPath for the collectionView with only a cell displayed
     
     - returns: The indexPath
     */
    func getVisibleIndexPath() -> NSIndexPath? {
        let visibleRect = CGRectMake(self.contentOffset.x,
            self.contentOffset.y,
            self.bounds.size.width,
            self.bounds.size.height)
        
        let visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect))
        
        var visibleIndexPath = self.indexPathForItemAtPoint(visiblePoint)
        if visibleIndexPath == nil {
            let cells = self.visibleCells()
            if cells.count > 0 {
                visibleIndexPath = self.indexPathForCell(cells[0])! as NSIndexPath
            }
        }
        return visibleIndexPath
    }
}

extension UIBarButtonItem {
    
    static func negativeSpacer(width : CGFloat) -> UIBarButtonItem {
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        spacer.width = width >= 0 ? -width : width
        return spacer
    }
}

