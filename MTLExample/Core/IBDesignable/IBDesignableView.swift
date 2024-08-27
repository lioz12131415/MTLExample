//
//  IBDesignableView.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

@IBDesignable
class IBDesignableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet { corners() }
    }
    
    @IBInspectable var leftTopCorners: Bool = false {
        didSet { corners() }
    }

    @IBInspectable var rightTopCorners: Bool = false {
        didSet { corners() }
    }
    
    @IBInspectable var leftBottomCorners: Bool = false {
        didSet { corners() }
    }
    
    @IBInspectable var rightBottomCorners: Bool = false {
        didSet { corners() }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        set { layer.borderColor = newValue.cgColor }
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 12, height: 12) {
        didSet { layer.shadowOffset = shadowOffset }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray {
        didSet { layer.shadowColor = shadowColor.cgColor }
    }
    
    @IBInspectable var shadowOpacity: Float = 1.0 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 1.0 {
        didSet { layer.shadowRadius = shadowRadius }
    }
    
    @IBInspectable var shadowPath: Bool = false {
        didSet { layer.shadowPath = CGPath(rect: bounds, transform: .none) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        super.invalidateIntrinsicContentSize()
    }
    
    fileprivate func corners() {
        var rectCorner = CACornerMask()
        
        if leftTopCorners     { rectCorner.insert(.layerMinXMinYCorner) }
        if rightTopCorners    { rectCorner.insert(.layerMaxXMinYCorner) }
        if leftBottomCorners  { rectCorner.insert(.layerMinXMaxYCorner) }
        if rightBottomCorners { rectCorner.insert(.layerMaxXMaxYCorner) }
        
        layer.cornerRadius  = cornerRadius
        layer.maskedCorners = rectCorner
    }
    
    fileprivate func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let size = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        let mask = CAShapeLayer()
        
        mask.path  = path.cgPath
        layer.mask = mask
    }
}

