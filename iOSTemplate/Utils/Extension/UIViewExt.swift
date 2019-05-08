//
//  UIViewExt.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/7/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import UIKit

extension UIView {
    func setGradientForBackground(type: Color.GradientType, startColor: UIColor, endColor: UIColor) {
        let gradientLayer = Color.makeGradientLayer(
            size: bounds.size,
            from: startColor,
            to: endColor,
            type: .topLeftToBottomRight
        )
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
