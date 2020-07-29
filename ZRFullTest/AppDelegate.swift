//
//  AppDelegate.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit

@UIApplicationMain



class AppDelegate: UIResponder, UIApplicationDelegate {
    var interStarte:NetWorkReachabState = .notReachab
    var ineterFaceRotation:UIInterfaceOrientationMask = .portrait
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startListenNetFunc()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController =  ZRTabViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return ineterFaceRotation
    }
    // 监听网络变化
    fileprivate func startListenNetFunc(){
        NetWorkManagerState.shared.statNetWorkReachablity { (state) in
            self.interStarte = state
            NotificationCenter.default.post(name: Notification.Name("helloWorld"), object: nil)
        }
    }
    
}

