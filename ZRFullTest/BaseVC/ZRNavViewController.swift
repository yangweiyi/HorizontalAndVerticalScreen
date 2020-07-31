//
//  ZRNavViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit

class ZRNavViewController: UINavigationController {
    lazy var navBtn: UIButton = {
        let navBtn = UIButton(type: .custom)
        navBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navBtn.setImage(UIImage(named: "login_back_icon"), for: .normal)
        navBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return navBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }
    @objc func buttonAction(){
        self.popViewController(animated: true)
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
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
extension ZRNavViewController: UINavigationControllerDelegate {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
