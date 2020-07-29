//
//  WelyBaseAnimator.swift
//  ZRMedical
//
//  Created by ywy on 2020/2/12.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit

class WelyBaseAnimator: NSObject {
    fileprivate var baseConfiguration: WelyBaseConfiguration

    public init(baseCong: WelyBaseConfiguration) {
        self.baseConfiguration = baseCong
        super.init()
    }
    // prepare  设置对应的  代理
    public func prepaerFunc(currentViewController: UIViewController) {
        currentViewController.modalPresentationStyle = .custom
        currentViewController.transitioningDelegate = self
    }
}
extension WelyBaseAnimator: UIViewControllerTransitioningDelegate {
    // ios  10.0  使用  暂不使用
    //    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    //    }

    //     如果模态方式是自定义的  且设置了transitionDelegate  则从UIKit 调用
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let baseVc = WelyPresentationController(presentedViewController: presented, presenting: presenting, baseConfig: self.baseConfiguration)
        return baseVc
    }
    // 模态弹出
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let slideInCong = baseConfiguration as? SlideInConfiguration {
            return SlideInAnimator(baseDirection: slideInCong.directionShow, basePresentaionType: .show, cong: slideInCong)
        } else if let fadeInCong = baseConfiguration as? FadeInConfiguration {
            return FadeInAnimator(basePresentationType: .show, cong: fadeInCong)
        } else if let shifInCong = baseConfiguration as? ShiftInConfiguration {
            return ShiftInAnimator(baseDirection: shifInCong.direction, basePresentationType: .show, cong: shifInCong)
        } else {
            return nil
        }
    }

    // 模态dismiss
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            if let slideInCong = baseConfiguration as? SlideInConfiguration {
                return SlideInAnimator(baseDirection: slideInCong.directionDimiss, basePresentaionType: .dismiss, cong: slideInCong)
            } else if let fadeInCong = baseConfiguration as? FadeInConfiguration {
                return FadeInAnimator(basePresentationType: .dismiss, cong: fadeInCong)
            } else if let shifInCong = baseConfiguration as? ShiftInConfiguration {
                return ShiftInAnimator(baseDirection: shifInCong.direction, basePresentationType: .dismiss, cong: shifInCong)
            } else {
                return nil
            }
    }

}
