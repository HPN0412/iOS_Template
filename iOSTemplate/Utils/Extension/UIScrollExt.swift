//
//  UIScrollExt.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/7/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import UIKit

extension UIScrollView {
    func addRefresh(color: UIColor = .black, handler: RefreshHandler?) {
        let refreshControl = UIRefreshControl(color: color, handler: handler)
        addSubview(refreshControl)
    }
}

typealias RefreshHandler = (UIRefreshControl) -> Void

final class HandleWrapper: NSObject {
    let handler: RefreshHandler?
    init(_ handler: RefreshHandler?) {
        self.handler = handler
    }
}

extension UIRefreshControl {
    private struct Associated {
        static var key = "Completion"
    }
    private var handler: RefreshHandler? {
        get {
            guard let completionWrapper = objc_getAssociatedObject(self, &Associated.key) as? HandleWrapper else { return nil }
            return completionWrapper.handler
        }
        set {
            objc_setAssociatedObject(self, &Associated.key, HandleWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    convenience init(color: UIColor = .black, handler: RefreshHandler?) {
        self.init()
        tintColor = color
        self.handler = handler
        addTarget(self, action: #selector(UIRefreshControl.refreshInvoke), for: .valueChanged)
    }

    @objc func refreshInvoke() {
        endRefreshing()
        handler?(self)
    }
}
