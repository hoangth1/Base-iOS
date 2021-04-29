//
//  UIViewExtension.swift
//  BaseiOS
//
//  Created by M1 on 4/29/21.
//

import Foundation
import UIKit
extension UIView{
    private func roundCorners(corners:UIRectCorner, radius:CGFloat){
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    private func shadowView(shadowColor:CGColor, shadowOffset: CGSize, shadowOpacity:Float = 1, shadowRadius:CGFloat = 1.0, isClipToBound:Bool = false){
        layer.shadowColor =   shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        self.clipsToBounds = isClipToBound
    }
}

extension UIView{
    public enum Visibility : Int {
        case visible = 0
        case invisible = 1
        case gone = 2
        case goneY = 3
        case goneX = 4
    }
    // set this property to control how view display in screen
    // This property will accept one of 5 values:  visible, invisible, gone, goneX, goneY
    public var visibility: Visibility {
        set {
            switch newValue {
            case .visible:
                isHidden = false
                getConstraintY(false)?.isActive = false
                getConstraintX(false)?.isActive = false
            case .invisible:
                isHidden = true
                getConstraintY(false)?.isActive = false
                getConstraintX(false)?.isActive = false
            case .gone:
                isHidden = true
                getConstraintY(true)?.isActive = true
                getConstraintX(true)?.isActive = true
            case .goneY:
                isHidden = true
                getConstraintY(true)?.isActive = true
                getConstraintX(false)?.isActive = false
            case .goneX:
                isHidden = true
                getConstraintY(false)?.isActive = false
                getConstraintX(true)?.isActive = true
            }
        }
        get {
            if isHidden == false {
                return .visible
            }
            if getConstraintY(false)?.isActive == true && getConstraintX(false)?.isActive == true {
                return .gone
            }
            if getConstraintY(false)?.isActive == true {
                return .goneY
            }
            if getConstraintX(false)?.isActive == true {
                return .goneX
            }
            return .invisible
        }
    }
    
    fileprivate func getConstraintY(_ createIfNotExists: Bool = false) -> NSLayoutConstraint? {
        return getConstraint(.height, createIfNotExists)
    }
    
    fileprivate func getConstraintX(_ createIfNotExists: Bool = false) -> NSLayoutConstraint? {
        return getConstraint(.width, createIfNotExists)
    }
    
    fileprivate func getConstraint(_ attribute: NSLayoutConstraint.Attribute, _ createIfNotExists: Bool = false) -> NSLayoutConstraint? {
        let identifier = "random_id"
        var result: NSLayoutConstraint? = nil
        for constraint in constraints {
            if constraint.identifier == identifier {
                result = constraint
                break
            }
        }
        if result == nil && createIfNotExists {
            // create and add the constraint
            result = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 0)
            result?.identifier = identifier
            addConstraint(result!)
        }
        return result
    }
}


extension UIView{
    func addSubViewFull(subViewAdd: UIView){
        subViewAdd.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(subViewAdd)
        subViewAdd.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        subViewAdd.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        subViewAdd.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        subViewAdd.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension UIView{
    // Method to remove all subviews
    func removeAllSubviews(){
        removeAllSubViews(from: self)
    }
    
    private func removeAllSubViews(from view:UIView){
        for  subview in view.subviews {
            removeAllSubViews(from: subview)
            if  subview.superview != nil {
                subview.removeFromSuperview()
            }
        }
    }
}


extension UIView{
    public func addBackgroundHorizontalGradient(withBottomColor bottomColor: UIColor, withTopColor topColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame
        gradientLayer.zPosition = -1
        
        self.layer.addSublayer(gradientLayer)
    }
    
    public func addBlurEffect(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        // supporting device rotation
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    public func removeAllBlurEffects() {
        removeAllBlurEffects(from: self)
    }
    
    private func removeAllBlurEffects(from view: UIView) {
        view.subviews.forEach { subview in
            removeAllBlurEffects(from: subview)
            if let _subview = subview as? UIVisualEffectView {
                _subview.removeFromSuperview()
            }
        }
    }
}
