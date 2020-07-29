//
//  ShiftInAnimator.swift
//  ZRMedical
//
//  Created by ywy on 2020/2/13.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit

class ShiftInAnimator: NSObject {
    
    let direction: WelyConstants.Direction
    let presentationType: WelyConstants.PresentationType
    let baseCong: ShiftInConfiguration
    
    init(baseDirection: WelyConstants.Direction, basePresentationType: WelyConstants.PresentationType, cong: ShiftInConfiguration) {
        self.direction = baseDirection
        self.presentationType = basePresentationType
        self.baseCong  =  cong
        super.init()
    }
}

extension ShiftInAnimator:UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return baseCong.duration.rawValue
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let  presentedKey = getPresentkeyForPresentationType(type: self.presentationType)
        let underlyingKey = getUnderlyingKeyForPresentationType(type: self.presentationType)
        let isPresentation = (presentedKey == .to)
        let presentedVC = transitionContext.viewController(forKey: presentedKey)!
        let  underlyVC = transitionContext.viewController(forKey: underlyingKey)!
        if isPresentation {
            transitionContext.containerView.addSubview(presentedVC.view)
        }
        
        // 飞出vc的 frame
        let presentedFrame = transitionContext.finalFrame(for: presentedVC)
        // 退出vc的 frame
        let  dimissFrame = getDimissFrameFunc(presnetedFrame: presentedFrame, direction: self.direction, transitionContext: transitionContext)
        
        var presentedFrameForUnderlying = transitionContext.containerView.frame
        //根据飞出vc的方向  更改底部VC起始位置
        switch self.baseCong.direction {
        case .left:
            //            presentedFrameForUnderlying.origin.x = presentedFrameForUnderlying.origin.x + presentedFrame.size.width
            presentedFrameForUnderlying.origin.x += presentedFrame.size.width
        case .right:
            //            presentedFrameForUnderlying.origin.x = presentedFrameForUnderlying.origin.x - presentedFrame.size.width
            presentedFrameForUnderlying.origin.x  -= presentedFrame.size.width
        case .top:
            //            presentedFrameForUnderlying.origin.y = presentedFrameForUnderlying.origin.y + presentedFrame.size.height
            presentedFrameForUnderlying.origin.y += presentedFrame.size.height
        case .bottom:
            //            presentedFrameForUnderlying.origin.y =  presentedFrameForUnderlying.origin.y  - presentedFrame.size.height
            presentedFrameForUnderlying.origin.y -= presentedFrame.size.height
        }
        let dismissedFrameForUnderLying = transitionContext.containerView.frame
        
        // 初始 飞出vc的frame
        let  initialFrameForPresented = isPresentation ? dimissFrame : presentedFrame
        // 最后退出 vc 的 frame
        let  finalFrameForPresented = isPresentation ? presentedFrame : dimissFrame
        // 初始 底部 vc 的 frame
        let inintialFrameForUndelying = isPresentation ? dismissedFrameForUnderLying : presentedFrameForUnderlying
        //最后 底部 vc 的 frame
        let  finalFrameForUndelying = isPresentation ? presentedFrameForUnderlying : dismissedFrameForUnderLying
        
        underlyVC.view.frame =  inintialFrameForUndelying
        presentedVC.view.frame =  initialFrameForPresented
        
        // 获取设置的时间间隔  == baseCong.duration.rawValue
        let   animationDuration = transitionDuration(using: transitionContext)
        
        let animationCurve = isPresentation ? baseCong.presentationCurve : baseCong.dismissCurve
        
        var animation = AnimationCoefficient()
        if isPresentation {
            animation =  baseCong.animationCeffion.covertAnimation()
        }
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: animation.damping, initialSpringVelocity: animation.velocity, options: animationCurve.getAnimationOptionForCurve(), animations: {
            // 设置动画
            underlyVC.view.frame = finalFrameForUndelying
            presentedVC.view.frame = finalFrameForPresented
            
        }) { (finish) in
            transitionContext.completeTransition(finish)
            //            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
extension ShiftInAnimator {
    fileprivate func  getDimissFrameFunc(presnetedFrame: CGRect, direction: WelyConstants.Direction, transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        var dismissedFrame: CGRect = presnetedFrame
        switch direction {
        case .left:
            dismissedFrame.origin.x =  -presnetedFrame.width
        case .right:
            dismissedFrame.origin.x =  transitionContext.containerView.frame.size.width
        case .top:
            dismissedFrame.origin.y =  -presnetedFrame.height
        case .bottom:
            dismissedFrame.origin.y =  transitionContext.containerView.frame.size.height
        }
        return dismissedFrame
    }
}
