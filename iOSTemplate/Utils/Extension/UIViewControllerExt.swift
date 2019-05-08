//
//  UIViewControllerExt.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/7/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import UIKit

extension UIWindow {
    var topViewController: UIViewController? {
        return rootViewController?.visibleController
    }
}

extension UIViewController {
    var visibleController: UIViewController? {
        switch self {
        case let navi as UINavigationController:
            return navi.visibleViewController?.visibleController
        case let tabBar as UITabBarController:
            return tabBar.selectedViewController?.visibleController
        case let controller where self.presentedViewController != nil:
            return controller.presentedViewController?.visibleController
        default:
            return self
        }
    }
}
