//
//  ZRNavViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit

class ZRNavViewController: UINavigationController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController!.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.topViewController!.preferredInterfaceOrientationForPresentation
    }
    
    override var shouldAutorotate: Bool {
        
        return self.topViewController!.shouldAutorotate
        
    }
    
    
    override var childForStatusBarHidden: UIViewController?{
        return self.topViewController
    }
    
}
