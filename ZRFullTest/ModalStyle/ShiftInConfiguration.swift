//
//  ShiftInConfiguration.swift
//  ZRMedical
//
//  Created by ywy on 2020/2/13.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit


public struct ShiftInConfiguration:WelyBaseConfiguration{
    
    public var duration: WelyConstants.Duration = .medium
    
    public var cornerRadius: Double = 0.0
    
    public var presentationCurve: WelyConstants.WelyCurve = .liner
    
    public var dismissCurve: WelyConstants.WelyCurve = .liner
    
    public var backgroudStlye: WelyConstants.BackgroudStyle = .blur(style: .extraLight)
    
    public var isTapBackToDismissEnabled: Bool =  true
    
    public var corners: UIRectCorner = [.topLeft,.topRight,.bottomLeft,.bottomRight]
    
    public var direction:WelyConstants.Direction = .bottom
    
    public var size:WelyConstants.ContainsSize = .halfScreen
    // 动画  阻尼
    public var animationCeffion:WelyConstants.Animationness = .none
    
}





