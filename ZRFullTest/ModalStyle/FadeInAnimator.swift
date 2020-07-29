//
//  FadeInAnimator.swift
//  ZRMedical
//
//  Created by ywy on 2020/2/13.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit

class FadeInAnimator: NSObject {
    let presentationType: WelyConstants.PresentationType
    let  baseCong: FadeInConfiguration
    
    init(basePresentationType: WelyConstants.PresentationType, cong: FadeInConfiguration) {
        self.presentationType = basePresentationType
        self.baseCong = cong
        super.init()
    }
}

extension FadeInAnimator:UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return baseCong.duration.rawValue
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 慢慢淡出 是修改的  alpha
        let  presentedKey = getPresentkeyForPresentationType(type: self.presentationType)
        let isPresentation = (presentedKey == .to)
        
        let presentedVC = transitionContext.viewController(forKey: presentedKey)!
        
        if isPresentation {
            transitionContext.containerView.addSubview(presentedVC.view)
        }
        let  presentedFrame = transitionContext.finalFrame(for: presentedVC)
        
        let  initalAlpha: CGFloat = isPresentation ? 0.0 : 1.0
        let  finalAlpha: CGFloat =  isPresentation ? 1.0 : 0.0
        
        presentedVC.view.frame = presentedFrame
        presentedVC.view.alpha = initalAlpha
        
        // 获取设置的时间间隔  == baseCong.duration.rawValue
        let   animationDuration = transitionDuration(using: transitionContext)
        
        let animationCurve = isPresentation ? baseCong.presentationCurve : baseCong.dismissCurve
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: animationCurve.getAnimationOptionForCurve(), animations: {
            // 设置动画
            presentedVC.view.alpha = finalAlpha
            
        }) { (finish) in
            transitionContext.completeTransition(finish)
            //            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension FadeInAnimator{
    fileprivate func  getDimissFrameFunc(presnetedFrame: CGRect, direction: WelyConstants.Direction, transitionContext:UIViewControllerContextTransitioning) -> CGRect {
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
