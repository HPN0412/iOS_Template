//
//  FontScale.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/7/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import UIKit
import SwifterSwift

extension UILabel {
    @IBInspectable var fontSize: CGFloat {
        get { return self.fontSize }
        set {
            font = font.withSize(newValue.scaling)
        }
    }
}

extension UITextField {
    @IBInspectable var fontSize: CGFloat {
        get { return self.fontSize }
        set {
            font = font?.withSize(newValue.scaling)
        }
    }
}

extension UITextView {
    @IBInspectable var fontSize: CGFloat {
        get { return self.fontSize }
        set {
            font = font?.withSize(newValue.scaling)
        }
    }
}

extension UIButton {
    @IBInspectable var fontSize: CGFloat {
        get { return self.fontSize }
        set {
            titleLabel?.font = titleLabel?.font?.withSize(newValue.scaling)
        }
    }
}

extension CGFloat {
    var scaling: CGFloat {
        return self * UIScreen.main.bounds.width / 375
    }

    func rounded(to place: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(place))
        return (self * divisor).rounded() / divisor
    }
}

extension Int {
    var scaling: CGFloat {
        return CGFloat(self) * UIScreen.main.bounds.width / 375
    }
}
