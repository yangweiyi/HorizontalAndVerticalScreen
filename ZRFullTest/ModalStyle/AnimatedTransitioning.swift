//
//  AnimatedTransitioning.swift
//  ZRMedical
//
//  Created by ywy on 2020/2/13.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewControllerAnimatedTransitioning{
    // 弹出VC 的key
    func getPresentkeyForPresentationType(type:WelyConstants.PresentationType) ->  UITransitionContextViewControllerKey{
        switch type {
        case .show:
            return .to
        case .dismiss:
            return .from
        }
    }
    
    // 底部VC的key
    func getUnderlyingKeyForPresentationType(type:WelyConstants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
        case .show:
            return .from
        case .dismiss:
            return .to
        }
    }
}
