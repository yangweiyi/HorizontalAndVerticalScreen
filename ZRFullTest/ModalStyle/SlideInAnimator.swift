//
//  SlideInAnimator.swift
//  ZRMedical
//
//  Created by ywy on 2020/2/13.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit

class SlideInAnimator: NSObject {

    let  direction:WelyConstants.Direction
    let  presentationType: WelyConstants.PresentationType
    let baseCong:SlideInConfiguration
    init(baseDirection: WelyConstants.Direction, basePresentaionType: WelyConstants.PresentationType, cong: SlideInConfiguration) {
        self.direction = baseDirection
        self.presentationType = basePresentaionType
        self.baseCong = cong
        super.init()
    }
}
extension SlideInAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return  baseCong.duration.rawValue
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let  presentedKey = getPresentkeyForPresentationType(type: self.presentationType)
        let isPresentation = (presentedKey == .to)
        
        let presentedVC = transitionContext.viewController(forKey: presentedKey)!
        
        if isPresentation {
            transitionContext.containerView.addSubview(presentedVC.view)
        }
        
        let  presentedFrame =  transitionContext.finalFrame(for: presentedVC)
        
        let  dimissedFrame = getDimissFrameFunc(presnetedFrame: presentedFrame, direction: self.direction, transitionContext: transitionContext)
        let initalFrame = isPresentation ? dimissedFrame : presentedFrame
        let  finalFrame =  isPresentation ? presentedFrame : dimissedFrame
        
        presentedVC.view.frame = initalFrame
        
        // 获取设置的时间间隔  == baseCong.duration.rawValue
        let   animationDuration = transitionDuration(using: transitionContext)
        
        let animationCurve = isPresentation ? baseCong.presentationCurve : baseCong.dismissCurve
        
        var animation = AnimationCoefficient()
        if isPresentation {
            animation =  baseCong.animationCeffion.covertAnimation()
        }
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: animation.damping, initialSpringVelocity: animation.velocity, options: animationCurve.getAnimationOptionForCurve(), animations: {
            // 设置动画
            presentedVC.view.frame = finalFrame
        }) { (finish) in
//            transitionContext.completeTransition(finish)
            transitionContext.completeTransition(finish)
            
        }
    }
}

extension SlideInAnimator {
    fileprivate func  getDimissFrameFunc(presnetedFrame:CGRect, direction:WelyConstants.Direction, transitionContext: UIViewControllerContextTransitioning) -> CGRect {
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
