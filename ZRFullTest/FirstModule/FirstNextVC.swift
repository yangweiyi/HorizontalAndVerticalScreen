//
//  FirstNextVC.swift
//  ZRFullTest
//
//  Created by ZR on 2020/7/31.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit
import SnapKit


class FirstNextVC: ZRBaseController {

    var isFullScreen: Bool = false // 是否全屏

    lazy var tearsView: TearsView = {
        let tearsView = TearsView()
        return tearsView
    }()

    lazy var namelabel: UILabel = {
        let name = UILabel()
        name.text = "请输入您的昵称!"
        name.textColor = .systemPink
        name.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        name.textAlignment = .center
        return name
    }()
    lazy var bottomTab: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .systemYellow
        return bottomView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tearsView)
        self.view.addSubview(bottomTab)
        bottomTab.addSubview(namelabel)
        addContFunc()
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeScreenFunc), name: UIDevice.orientationDidChangeNotification, object: nil)
        tearViewAllBlockFunc()
    }
    fileprivate func tearViewAllBlockFunc() {
        tearsView.backButtonBlock = {
            if self.isFullScreen {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }

        tearsView.fullScreenBlock = {
            if self.isFullScreen == true {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            } else {
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        ZRApp.ineterFaceRotation = .all
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ZRApp.ineterFaceRotation = .portrait
    }
    fileprivate func addContFunc() {
        tearsView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(ScreenBounds.Width / 16 * 9)
        }
        namelabel.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(5)
        }
        bottomTab.snp.makeConstraints { (maker) in
            maker.bottom.left.right.equalToSuperview()
            maker.top.equalTo(tearsView.snp.bottom)
        }
    }
    // 横竖屏间提供
    @objc func didChangeScreenFunc() {
        let status = UIApplication.shared.statusBarOrientation
        if status.isPortrait, isFullScreen {
            isFullScreen = false
            smallScreenFunc()
        }
        if status.isLandscape, isFullScreen == false {
            isFullScreen = true
            fullScreenFunc()
        }
    }

    fileprivate func smallScreenFunc() {
        UIView.animate(withDuration: 0.3) {
            self.tearsView.snp.updateConstraints { (maker) in
                maker.height.equalTo(ScreenBounds.Width / 16 * 9)
            }
        }
    }

    fileprivate func fullScreenFunc() {
        UIView.animate(withDuration: 0.3) {
            self.tearsView.snp.updateConstraints { (maker) in
                maker.height.equalTo(ScreenBounds.Width)
            }
        }
    }
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
}
