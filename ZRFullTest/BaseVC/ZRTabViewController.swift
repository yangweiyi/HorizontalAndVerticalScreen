//
//  ZRTabViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit


extension UIColor{
    static func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
}

class ZRTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabItem()
        setUpChilderVC(baseVC: FirstViewController(), tabTitle: "第一", navTitle: "第一")
        setUpChilderVC(baseVC: SecondViewController(), tabTitle: "第二", navTitle: "第二")
        setUpChilderVC(baseVC: ThirdViewController(), tabTitle: "第三", navTitle: "第三")
    }
    
    func initTabItem() -> Void {
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.RGBA(r: 102, g: 102, b: 102, a: 1.0)
        } else {
            // Fallback on earlier versions
            self.tabBar.barTintColor = UIColor.RGBA(r: 102, g: 102, b: 102, a: 1.0)
        }
        self.tabBar.tintColor = UIColor.RGBA(r: 8, g: 126, b: 102, a: 1.0)
        self.tabBar.isTranslucent = false
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundColor = .white
    }
    
    func setUpChilderVC(baseVC:ZRBaseController,tabTitle:String,navTitle:String) -> Void {
        
        let baseNav = ZRNavViewController(rootViewController: baseVC)
        self.addChild(baseNav)
        baseNav.tabBarItem.title = tabTitle
        baseNav.navigationItem.title = navTitle
        
//        baseNav.tabBarItem.image = UIImage.imageForm("",image).withRenderingMode(.alwaysOriginal)
//        baseNav.tabBarItem.selectedImage = UIImage.imageForm("",imageSelecged).withRenderingMode(.alwaysOriginal)
    }
    
      override var shouldAutorotate: Bool{
        return self.selectedViewController?.shouldAutorotate ?? false
      }
      override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return self.selectedViewController?.preferredInterfaceOrientationForPresentation ?? UIInterfaceOrientation.portrait
      }
      override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return self.selectedViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
      }
    
    
}
