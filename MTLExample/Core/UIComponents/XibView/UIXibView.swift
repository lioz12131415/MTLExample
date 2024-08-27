//
//  UIXibView.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

open class UIXibView: UIView, NibReplaceable {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        guard subviews.isEmpty, let nibView = replacedByNibView() else { return }
        nibView.frame            = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(nibView)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        guard subviews.isEmpty, let nibView = replacedByNibView() else { return }
        nibView.frame            = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(nibView)
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        super.invalidateIntrinsicContentSize()
    }
}

public protocol NibReplaceable where Self: UIView {
    
}

extension NibReplaceable {
    fileprivate func replacedByNibView() -> UIView? {
        let nibView = type(of: self).nibView(withOwner: self)
        return nibView
    }
}

extension NibReplaceable {
    static func nibView(withOwner ownerOrNil: Any? = nil) -> UIView? {
        let nib  = UINib(nibName: nibName, bundle: Bundle(for: self))
        let view = nib.instantiate(withOwner: ownerOrNil, options: nil)[0] as? UIView
        return view
    }
}

extension NibReplaceable {
    static var nibName: String {
        return String(describing: self)
    }
}

