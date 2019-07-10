//
//  CornerView.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/7/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import UIKit
import PureLayout

final class AlertViewController: UIViewController {
    enum Style {
        case alert
        case actionSheet
    }

    @IBOutlet weak var contentView: UIView!
    var style: AlertViewController.Style = .alert
    var tap: UITapGestureRecognizer!
    var shouldDismissOnTouchOutside: Bool = false {
        didSet {
            tap.isEnabled = shouldDismissOnTouchOutside
        }
    }

    init(preferredStyle: AlertViewController.Style = .alert) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        transitioningDelegate = self
        style = preferredStyle
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        tap.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(tap)
        view.backgroundColor = .clear
        view.isOpaque = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    @IBAction func dismissPopup() {
        dismiss()
    }

    func dismiss(completion: (() -> Void)? = nil) {
        self.dismiss(animated: true)
        completion?()
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension AlertViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if style == .alert {
            return AlertAnimationTransition(.present)
        }
        return ActionSheetAnimationTransition(.present)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if style == .alert {
            return AlertAnimationTransition(.dismiss)
        }
        return ActionSheetAnimationTransition(.dismiss)
    }
}

final class ActionSheetAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    enum Transition {
        case present
        case dismiss
    }
    private var transition: Transition = .dismiss

    init(_ transition: Transition) {
        super.init()
        self.transition = transition
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transition == .present {
            animatePresentation(with: transitionContext)
        } else {
            animateDismissal(with: transitionContext)
        }
    }

    private func animatePresentation(with transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toController = transitionContext.viewController(forKey: .to) as? AlertViewController else { return }
        containerView.addSubview(toController.view)
        toController.view.autoPinEdgesToSuperviewEdges()
        toController.view.layoutIfNeeded()
        toController.contentView.frame.origin.y += toController.contentView.height
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                toController.contentView.frame.origin.y -= toController.contentView.height
//                containerView.backgroundColor = Color.popUpBackground
                containerView.backgroundColor = .black
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }

    private func animateDismissal(with transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromController = transitionContext.viewController(forKey: .from) as? AlertViewController else { return }
        containerView.addSubview(fromController.view)
        fromController.view.isHidden = true
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                containerView.backgroundColor = .clear
                fromController.contentView.frame.origin.y += fromController.contentView.height
            }, completion: { (_) in
                fromController.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }

}

final class AlertAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    enum Transition {
        case present
        case dismiss
    }

    private var transition: Transition = .dismiss

    init(_ transition: Transition) {
        super.init()
        self.transition = transition
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transition == .present {
            animatePresentation(with: transitionContext)
        } else {
            animateDismissal(with: transitionContext)
        }
    }

    private func animatePresentation(with transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toController = transitionContext.viewController(forKey: .to) as? AlertViewController else { return }
        containerView.addSubview(toController.view)
        toController.view.autoPinEdgesToSuperviewEdges()
        toController.view.layoutIfNeeded()
        guard let snapshot = toController.view.snapshotView(afterScreenUpdates: true) else { return }
        containerView.addSubview(snapshot)
        snapshot.autoPinEdgesToSuperviewEdges()
        snapshot.alpha = 0
        snapshot.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        toController.view.isHidden = true
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                containerView.backgroundColor = .black
                snapshot.alpha = 1
                snapshot.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { _ in
                toController.view.isHidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }

    private func animateDismissal(with transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromController = transitionContext.viewController(forKey: .from) as? AlertViewController else { return }
        containerView.addSubview(fromController.view)
        guard let snapshot = fromController.contentView.snapshotView(afterScreenUpdates: false) else { return }
        let x = fromController.contentView.x
        let y = fromController.contentView.y + fromController.view.y
        snapshot.frame.origin = CGPoint(x: x, y: y)
        snapshot.transform = CGAffineTransform(scaleX: 1, y: 1)
        fromController.view.isHidden = true
        containerView.addSubview(snapshot)
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                containerView.backgroundColor = .clear
                snapshot.alpha = 0
                snapshot.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { (_) in
                fromController.view.isHidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }
}

extension AlertViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let isDescendant = touch.view?.isDescendant(of: contentView) else { return false }
        return !isDescendant
    }
}
