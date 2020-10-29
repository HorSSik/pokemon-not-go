//
//  UIView+Extensions.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 29.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    public var cornerPropotion: Double {
        set(propoprion) {
            let side = min(self.frame.height, self.frame.width)
            
            self.layer.cornerRadius = side * CGFloat(propoprion)
            self.layer.masksToBounds = true
        }
        
        get {
            fatalError()
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        set(radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
        
        get {
            return self.layer.cornerRadius
        }
    }

    @IBInspectable
    public var borderColor: UIColor? {
        set(color) {
            self.layer.borderColor = color?.cgColor
        }
        
        get {
            return self.layer.borderColor != nil ? UIColor(cgColor:self.layer.borderColor!) : nil
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        set(width) {
            self.layer.borderWidth = width
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    public func shake(
        duration: TimeInterval,
        animationValues: [Double] = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.0, 2.0, 0.0 ],
        execute: () -> ()
    ) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.values = animationValues
        
        self.layer.add(animation, forKey: "shake")
        execute()
    }
    
    public func setShadow(
        color: UIColor = UIColor.darkGray,
        opacity: Float = 0.5,
        shadowOffset: CGSize = CGSize(width: 1, height: 1),
        radius: CGFloat = 1,
        cornerRadius: CGFloat = 0,
        shouldRasterize: Bool = false
    ) {
        let view = UIView(frame: self.bounds)

        view.drawShadow(
            color: color,
            opacity: opacity,
            shadowOffset: shadowOffset,
            radius: radius,
            cornerRadius: cornerRadius,
            shouldRasterize: shouldRasterize
        )

        self.superview?.insertSubview(view, belowSubview: self)
    }

    //  used when view.clipToBounds is 'false'
    public func drawShadow(
        in frame: CGRect? = nil,
        color: UIColor = UIColor.darkGray,
        opacity: Float = 0.1,
        shadowOffset: CGSize = CGSize(width: 1, height: 1),
        radius: CGFloat = 15,
        cornerRadius: CGFloat = 0,
        shouldRasterize: Bool = false
    ) {
        let layer = self.layer

        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(roundedRect: frame ?? self.bounds, cornerRadius: cornerRadius).cgPath
        
        if shouldRasterize {
            layer.rasterizationScale = UIScreen.main.scale
            layer.shouldRasterize = shouldRasterize
        }
    }

    public func setRoundShadow() {
        let shadowOffset = CGSize(width: 0, height: 10)
        
        self.setShadow(opacity: 0.2, shadowOffset: shadowOffset, radius: 10, cornerRadius: self.frame.height / 2)
    }
    
    public func roundTop(cornerRadius: CGFloat = 20) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.topRight, .topLeft],
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = path.cgPath
        self.layer.mask = layer
    }
    
    public func roundBottom(cornerRadius: CGFloat = 20) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.bottomRight, .bottomLeft],
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = path.cgPath
        self.layer.mask = layer
    }
    
    public func resetRoundedCorners() {
        self.roundTop(cornerRadius: 0)
        self.roundBottom(cornerRadius: 0)
        self.cornerRadius = 0
    }
}
