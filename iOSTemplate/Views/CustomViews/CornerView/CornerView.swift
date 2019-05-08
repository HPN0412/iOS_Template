//
//  CornerView.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/7/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import UIKit

@IBDesignable
final class View: UIView {
    
    @IBInspectable var topLeft: Bool = false {
        didSet {
            if topLeft {
                roundedCorners.insert(.topLeft)
            } else {
                roundedCorners.remove(.topLeft)
            }
        }
    }
    
    @IBInspectable var topRight: Bool = false {
        didSet {
            if topRight {
                roundedCorners.insert(.topRight)
            } else {
                roundedCorners.remove(.topRight)
            }
        }
    }
    
    @IBInspectable var bottomLeft: Bool = false {
        didSet {
            if bottomLeft {
                roundedCorners.insert(.bottomLeft)
            } else {
                roundedCorners.remove(.bottomLeft)
            }
        }
    }
    
    @IBInspectable var bottomRight: Bool = false {
        didSet {
            if bottomRight {
                roundedCorners.insert(.bottomRight)
            } else {
                roundedCorners.remove(.bottomRight)
            }
        }
    }
    
    @IBInspectable var corner: CGFloat = 0
    @IBInspectable var colorBorder: UIColor = .white
    @IBInspectable var fillColor: UIColor = .white
    @IBInspectable var isFill: Bool = true
    @IBInspectable var lineWidth: CGFloat = 1
    @IBInspectable var insetDx: CGFloat = 0
    @IBInspectable var insetDy: CGFloat = 0
    @IBInspectable var offsetShadow: CGSize = CGSize.zero
    @IBInspectable var shadowBlur: CGFloat = 10
    @IBInspectable var colorShadow: UIColor = .clear
    
    var roundedCorners: UIRectCorner = []
    
    convenience init(corner: CGFloat, rectCorner: UIRectCorner) {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
        self.corner = corner
        self.roundedCorners = rectCorner
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawBackground(rectangle: rect)
    }
    
    private func drawBackground(rectangle backgroundRectangle: CGRect) {
        let tileRectangle = backgroundRectangle.insetBy(dx: insetDx.scaling, dy: insetDy.scaling)
        let context = UIGraphicsGetCurrentContext()
        if let context = context {
            context.setShadow(offset: offsetShadow, blur: shadowBlur, color: colorShadow.cgColor)
            context.beginTransparencyLayer(auxiliaryInfo: nil)
            let borderPath = UIBezierPath(
                roundedRect: tileRectangle,
                byRoundingCorners: roundedCorners,
                cornerRadii: CGSize(width: corner.scaling, height: corner.scaling)
            )
            colorBorder.set()
            borderPath.lineWidth = lineWidth
            borderPath.lineCapStyle = .square
            borderPath.stroke()
            if isFill {
                fillColor.setFill()
                borderPath.fill()
            }
            context.endTransparencyLayer()
        }
    }
}


