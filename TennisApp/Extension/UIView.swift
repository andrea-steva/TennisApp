//
//  UIView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 20/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

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
