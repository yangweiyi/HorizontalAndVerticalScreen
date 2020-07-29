//
//  FirstViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit
import SnapKit


class FirstViewController: ZRBaseController {
    var isFinishPortraind: Bool = true // 是否完成竖屏
    var isFullScreen: Bool = false // 是否全屏

    lazy var playerView: UIView = {
        let playerView = UIView()
        playerView.isUserInteractionEnabled = true
        playerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fullClickFunc)))
        playerView.backgroundColor = .systemPink
        return playerView
    }()

    lazy var nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "请输入您的昵称!"
        name.textColor = .yellow
        name.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        name.textAlignment = .center
        return name
    }()

    lazy var bottomTab: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .systemYellow
        return bottomView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        ZRApp.ineterFaceRotation = .all
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(playerView)
        playerView.addSubview(nameTextField)
        self.view.addSubview(bottomTab)
        addContFunc()
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeScreenFunc), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    fileprivate func addContFunc() {
        playerView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(ScreenBounds.Width / 16 * 9)
        }
        nameTextField.snp.makeConstraints { (maker) in
            maker.center.left.right.equalToSuperview()
            maker.height.equalTo(60)
        }

        bottomTab.snp.makeConstraints { (maker) in
            maker.bottom.left.right.equalToSuperview()
            maker.top.equalTo(playerView.snp.bottom)
        }
    }
    // 点击
    @objc func fullClickFunc() {
        if isFullScreen == true {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        } else {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        }
    }
    // 横竖屏间提供
    @objc func didChangeScreenFunc() {

//
//        return
//
//

        let screenOr = UIDevice.current.orientation
        if screenOr == .portrait,isFullScreen {
//            var duration:TimeInterval  =  0
            // 竖屏处理
            isFullScreen = false
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.snp.updateConstraints { (maker) in
                    maker.height.equalTo(ScreenBounds.Width / 16 * 9)
                }
                self.isFinishPortraind = false
            }) { (isOk) in
                self.isFinishPortraind = true
                self.portraitFinishaNextAction()
            }
        }

        if screenOr == .landscapeLeft, !isFullScreen {
            // 左边
//            self.playerView.snp.updateConstraints { (maker) in
//                maker.height.equalTo(ScreenBounds.Width / 16 * 9)
//            }
            isFullScreen = true
            UIView.animate(withDuration: 0.3, animations: {
                if self.isFinishPortraind == true {
                    self.playerView.snp.updateConstraints { (maker) in
                        maker.height.equalTo(ScreenBounds.Width)
                    }
                }

            }) { (isOk) in

            }
        }

        if screenOr == .landscapeRight, !isFullScreen {
            // 右边
            isFullScreen = true
            UIView.animate(withDuration: 0.3, animations: {

            }) { (idOk) in
                if self.isFinishPortraind == true {
                    self.playerView.snp.updateConstraints { (maker) in
                        maker.height.equalTo(ScreenBounds.Width)
                    }
                }
            }
        }
    }


    fileprivate func portraitFinishaNextAction() {
        let orient = UIDevice.current.orientation
        if orient == .landscapeLeft || orient == .landscapeRight {
            UIView.animate(withDuration: 03, delay: 03, options: .layoutSubviews, animations: {
                if self.isFinishPortraind == true {
                    self.playerView.snp.updateConstraints { (maker) in
                        maker.height.equalTo(ScreenBounds.Width / 16 * 9)
                    }
                }
            }) { (isOk) in
                self.playerView.snp.updateConstraints { (maker) in
                    maker.height.equalTo(ScreenBounds.Width)
                }
            }
        }

    }




//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//
//
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
    }




    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }







}
