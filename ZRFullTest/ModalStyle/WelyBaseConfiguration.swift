//
//  WelyBaseConfiguration.swift
//  ZRMedical
//
//  Created by ywy on 2020/2/12.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit

// 此处表示 基本控制
public protocol WelyBaseConfiguration {
    var duration: WelyConstants.Duration {get set}
    var cornerRadius:Double {get set}
    var presentationCurve: WelyConstants.WelyCurve {get set}
    var dismissCurve:WelyConstants.WelyCurve {get set}
    var backgroudStlye:WelyConstants.BackgroudStyle {get  set}
    var isTapBackToDismissEnabled: Bool {get set}
    var corners: UIRectCorner {get set}
}
// 提供垂直 || 水平方向
public protocol HorizontalAndPortraitType {
    var verticalType: WelyConstants.VerticalAlignment {get set}
    var horizontalType: WelyConstants.HorizontalAlignment {get  set}
}
// 提供尺寸大小
public protocol DefinitionVcFrame {
    var widthForVC: WelyConstants.ContainsSize {get  set}
    var hightForVC: WelyConstants.ContainsSize {get  set}
    var marginGuards: UIEdgeInsets {get  set}
}
//常量 设置
public struct WelyConstants{
    // 水平方向
    public enum HorizontalAlignment {
        case left
        case right
        case center
        case custom(horx: CGFloat)
    }
    // 垂直方向
    public enum VerticalAlignment{
        case top
        case bottom
        case center
        case custom(very: CGFloat)
    }
    // 包含 size
    public enum ContainsSize {
        case fullScreen
        case halfScreen
        case custom(value: CGFloat)
    }
    // 背景风格
    public enum BackgroudStyle {
        case customDark(alpha: CGFloat)
        case blur(style: UIBlurEffect.Style)
    }
    
    public enum  PresentationType {
        case show
        case dismiss
    }
    //  视图  飞出  和 进入 方向
    public enum Direction {
        case top
        case bottom
        case left
        case right
        
        func getOrientation() -> Orientation {
            switch self {
            case .left, .right:
                return .horizontal
            case .top, .bottom:
                return .vertical
            }
        }
    }
    
    public enum Orientation {
        case horizontal
        case vertical
    }
    // 视图飞出 和 进入的的时间间隔
    public enum Duration: TimeInterval {
        case ultraSlow = 2.0 // 超慢
        case slow = 1.0 // 慢
        case medium = 0.5 // 中等
        case normal = 0.3 // 正常
        case fast = 0.2 // 快
        case ultrafast = 0.1 // 超快
    }
    // 动画曲线
    public enum WelyCurve {
        case easeInEaseOut
        case easeIn
        case easeOut
        case liner // 线性
        
        // 返回动画
        public func getAnimationOptionForCurve() -> UIView.AnimationOptions {
            switch self {
            case .easeInEaseOut:
                return .curveEaseOut
            case .easeIn:
                return .curveEaseIn
            case .easeOut:
                return .curveEaseOut
            case .liner:
                return .curveLinear
            }
        }
        
    }
    
    // 动画系数
    public enum Animationness {
        case none
        case animationNormal
        case animationer
        case animationEst
        
        func covertAnimation() -> AnimationCoefficient {
            var damping: CGFloat = 1.0
            var velocity: CGFloat = 0.0
            switch self {
            case .none: break
            case .animationNormal:
                damping = 0.7
                velocity = 2
            case .animationer:
                damping = 0.5
                velocity = 3
            case .animationEst:
                damping = 0.2
                velocity = 4
            }
            return AnimationCoefficient(damping: damping, velocity: velocity)
        }
    }
    
}
// 动画系数设置  阻尼  和  速度
public struct AnimationCoefficient {
    
    public var  damping: CGFloat
    public var velocity: CGFloat
    
    init(damping: CGFloat = 1.0, velocity: CGFloat = 1.0) {
        self.damping =  damping
        self.velocity =  velocity
    }
    
}
