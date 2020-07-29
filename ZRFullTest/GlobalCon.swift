//
//  GlobalCon.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import UIKit


struct ScreenBounds {
    static let Height = UIScreen.main.bounds.height
    static let Width = UIScreen.main.bounds.width
    static let StatusH = getStatusBarFrmae()
    static let NavH = CGFloat(44)
    static let Top = StatusH! + NavH
    static let SafeH = Int(StatusH!) > 20 ? 34 : 0
    static let BottomH =  49 + CGFloat(SafeH)
}

func getStatusBarFrmae() -> CGFloat? {
    var statusHight:CGFloat?
    if #available(iOS 13.0, *) {
        statusHight = UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height
    }else{
        statusHight = UIApplication.shared.statusBarFrame.size.height
    }
    return statusHight
}

func ZRRect(x:CGFloat,y:CGFloat,width:CGFloat,hight:CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: hight)
}

let ZRApp = UIApplication.shared.delegate as! AppDelegate

