//
//  WelyPresentationController.swift
//  ZRMedical
//
//  Created by ywy on 2020/2/12.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit

class WelyPresentationController: UIPresentationController {

    fileprivate var baseCong: WelyBaseConfiguration
    // 自定义背景
    fileprivate var dimmingView: UIView = UIView()
    // 模糊效果
    fileprivate var blurView: UIVisualEffectView = UIVisualEffectView()

    // 初始化  增加自定义参数
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, baseConfig: WelyBaseConfiguration) {

        self.baseCong = baseConfig

        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        presentedViewController.view.layer.masksToBounds = true
        //        presentedViewController.view.roundCorners(corners: <#T##UIRectCorner#>, radius: T##Double)


    }

    // 视图将要显示
    override func presentationTransitionWillBegin() {
        switch self.baseCong.backgroudStlye {
        case .blur(style: let effectStyle):
            setUpblurViewfunc()
            animateBlurView(style: effectStyle)
        case .customDark(alpha: let alpha):
            setUpDimmedViewFunc(alpha: alpha)
            animateDimmingView()
        }
    }
    // 视图 frame
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.roundCorners(corners: baseCong.corners, radius: baseCong.cornerRadius)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        // 设置view大小
        if let shiftIn = baseCong as? ShiftInConfiguration {
            return setFrameForShiftIn(config: shiftIn)
        }
        guard let defineVcFrame = baseCong as? DefinitionVcFrame else {
            return CGRect(x: 0, y: 0, width: (containerView?.bounds.size.width)!, height: containerView!.bounds.size.height)
        }

        var viewFrame: CGRect = .zero
        // 根据提供的 宽高   设置大小
        viewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        // 根据提供的 位置 对齐 view
        align(frame: &viewFrame, baseCong: baseCong)
        // 设置 约束大小
        applyConstraintFunc(frame: &viewFrame, constraint: defineVcFrame.marginGuards, container: (containerView?.bounds.size)!)
        return viewFrame
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        guard let nonFullScreen = self.baseCong as? DefinitionVcFrame else {
            return parentSize
        }
        var childWidth: CGFloat = 0.0
        switch nonFullScreen.widthForVC {
        case .fullScreen:
            childWidth = parentSize.width
        case .halfScreen:
            childWidth = parentSize.width / 2
        case .custom(let value):
            childWidth = value
        }
        var childHeight: CGFloat = 0.0
        switch nonFullScreen.hightForVC {
        case .fullScreen:
            childHeight = parentSize.height
        case .halfScreen:
            childHeight = parentSize.height / 2
        case .custom(let value):
            childHeight = value
        }
        return CGSize(width: childWidth, height: childHeight)
    }

    // 设置view 的 起始点
    fileprivate func align(frame: inout CGRect, baseCong: WelyBaseConfiguration) {

        let viewSize = containerView!.frame.size

        if let horizontalVer = baseCong as? HorizontalAndPortraitType {
            // 设置 origin.x
            switch horizontalVer.horizontalType {
            case .center:
                frame.origin.x = viewSize.width / 2 - (frame.size.width / 2)
            case .custom(horx: let value):
                frame.origin.x = value
            case .left:
                frame.origin.x = 0
            case .right:
                frame.origin.x = viewSize.width - frame.size.width
            }
            // 设置 origin.y
            switch horizontalVer.verticalType {
            case .center:
                frame.origin.y = viewSize.height / 2 - (frame.size.height / 2)
            case .top:
                frame.origin.y = 0
            case .bottom:
                frame.origin.y = viewSize.height - frame.size.height
            case .custom(let value):
                frame.origin.y = value
            }
        } else {
            // 默认水平 垂直居中
            frame.origin.x = viewSize.width / 2 - (frame.size.width / 2)
            frame.origin.y = viewSize.height / 2 - (frame.size.height / 2)

        }
    }
    // 设置 view 的约束
    fileprivate func applyConstraintFunc(frame: inout CGRect, constraint: UIEdgeInsets, container: CGSize) {
        // 水平约束
        if frame.origin.x <= 0 {
            frame.origin.x = constraint.left
        }

        if (frame.origin.x + frame.width) >= (container.width - constraint.right) {
            let leftSpace = (frame.origin.x + frame.width) - container.width
            frame.size.width = frame.width - leftSpace - constraint.right
        }
        // 垂直约束
        if frame.origin.y <= 0 {
            frame.origin.y = constraint.top
        }
        if (frame.origin.y + frame.height) >= (container.height - constraint.bottom) {
            let space = (frame.origin.y + frame.height) - container.height
            frame.size.height = frame.height - space - constraint.bottom
        }

    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            blurView.effect = nil
            return
        }
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.0
            self.blurView.effect = nil
        }) { (_) in
        }
    }
}

// 设置不同类型frame的大小
extension WelyPresentationController {

    fileprivate func setFrameForShiftIn(config: ShiftInConfiguration) -> CGRect {
        var shiftInFrame: CGRect = .zero
        let widthOfSize = getSizeValue(shiftConfig: config)
        switch config.direction {
        case .left:
            shiftInFrame = CGRect(x: 0, y: 0, width: widthOfSize, height: containerView!.bounds.size.height)
        case .right:
            shiftInFrame = CGRect(x: containerView!.bounds.size.width - widthOfSize, y: 0, width: widthOfSize, height: containerView!.bounds.size.height)
        case .top:
            shiftInFrame = CGRect(x: 0, y: 0, width: containerView!.bounds.size.width, height: widthOfSize)
        case .bottom:
            shiftInFrame = CGRect(x: 0, y: containerView!.bounds.size.height - widthOfSize, width: containerView!.bounds.size.width, height: widthOfSize)
        }
        return shiftInFrame
    }
    fileprivate func getSizeValue(shiftConfig: ShiftInConfiguration) -> CGFloat {
        let fullHeight = (self.containerView?.frame.size.height)!
        let fullWidth = (self.containerView?.frame.size.width)!
        switch shiftConfig.size {
        case .fullScreen:
            if shiftConfig.direction.getOrientation() == .horizontal {
                return fullWidth
            } else {
                return fullHeight
            }
        case .halfScreen:
            if shiftConfig.direction.getOrientation() == .horizontal {
                return fullWidth / 2
            } else {
                return fullHeight / 2
            }
        case .custom(let value):
            return value
        }
    }
}

extension WelyPresentationController {

    fileprivate func setUpblurViewfunc() {

        guard let container = containerView else { return }
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(handleTap(tapnizer:)))
        //      blurView.insertSubview(blurView, at: 0)
        blurView.addGestureRecognizer(tapGes)
        container.addSubview(blurView)
        blurView.snp.makeConstraints { (maker) in
            maker.left.right.bottom.bottom.equalToSuperview()
        }
    }
    fileprivate func animateBlurView(style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        guard let coordinator = presentedViewController.transitionCoordinator else {
            self.blurView.effect = effect
            return
        }

        coordinator.animate(alongsideTransition: { (_) in
            self.blurView.effect = effect
        }, completion: { (_) in

            })

    }

    fileprivate func setUpDimmedViewFunc(alpha: CGFloat) {

        guard let container = containerView else { return }
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alpha = 0.0
        dimmingView.backgroundColor = UIColor(white: 0, alpha: alpha)
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(handleTap(tapnizer:)))
        dimmingView.addGestureRecognizer(tapGes)
        container.addSubview(dimmingView)
        dimmingView.snp.makeConstraints { (maker) in
            maker.left.right.bottom.top.equalToSuperview()
        }

    }

    fileprivate func animateDimmingView() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 1.0
        }, completion: { (_) in
        })
    }

    @objc func handleTap(tapnizer: UITapGestureRecognizer) {
        if baseCong.isTapBackToDismissEnabled == true {
            presentingViewController.dismiss(animated: true)
        }
    }
}
extension UIView{
    public func roundCorners(corners: UIRectCorner = .allCorners, radius: Double = 0.0) {
        self.layer.masksToBounds = true
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.frame = bounds
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
}
