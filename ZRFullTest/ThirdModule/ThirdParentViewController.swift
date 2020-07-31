//
//  ThirdParentViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/7/31.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit

class ThirdParentViewController: ZRBaseController {


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        ZRApp.ineterFaceRotation = .landscape
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeScreenFunc), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func didChangeScreenFunc() {
        let status = UIApplication.shared.statusBarOrientation
        if status.isPortrait {
            self.dismiss(animated: true, completion: nil)
        }
    }
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()

        ZRApp.ineterFaceRotation = .portrait

    }


}
