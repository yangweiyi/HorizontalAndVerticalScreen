//
//  SecondNextVC.swift
//  ZRFullTest
//
//  Created by ZR on 2020/7/31.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit
import SnapKit

class SecondNextVC: ZRBaseController {
    final var isFullScreen: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    final var parentView: UIView = UIView()
    final var parentFrame: CGRect = CGRect.zero

    lazy var secondTearsView: TearsView = {
        let secondView = TearsView()
        secondView.frame = ZRRect(x: 0, y: 0, width: ScreenBounds.Width, hight: ScreenBounds.Width / 16 * 9)
        return secondView
    }()

    lazy var secondSuperView: UIView = {
        let secondSuper = UIView()
        secondSuper.frame = ZRRect(x: 0, y: 0, width: ScreenBounds.Width, hight: ScreenBounds.Width / 16 * 9)
        return secondSuper
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        ZRApp.ineterFaceRotation = .all
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeScreenFunc), name: UIDevice.orientationDidChangeNotification, object: nil)
        view.addSubview(secondSuperView)
        secondSuperView.addSubview(secondTearsView)
//        seconViewConstrainsFunc()

        secondViewAllBlockFunc()

    }

    fileprivate func seconViewConstrainsFunc() {
        secondSuperView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(ScreenBounds.Width / 16 * 9)
        }
        secondTearsView.snp.makeConstraints { (maker) in
            maker.top.left.right.bottom.equalToSuperview()
        }

    }

    fileprivate func secondViewAllBlockFunc() {
        secondTearsView.backButtonBlock = {
            if self.isFullScreen {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }

        secondTearsView.fullScreenBlock = {
            if self.isFullScreen == true {
                self.exitFullScreenFunc()
            } else {
                self.enterFullScreenFunc()
            }
        }
    }
    // 横竖屏监听
    @objc func didChangeScreenFunc() {
        let device = UIDevice.current.orientation
        switch device {
        case .portrait:
            exitFullScreenFunc()
        case .landscapeLeft:
            guard isFullScreen == false else {
                return
            }
            enterFullScreenFunc()
        case .landscapeRight:
            guard isFullScreen == false else {
                return
            }
            enterFullScreenFunc()
        default: break
        }
    }
    // 横屏
    fileprivate func enterFullScreenFunc() {
//        guard isFullScreen == false else {
//            return
//        }

        parentView = self.secondTearsView.superview ?? UIView()
        parentFrame = self.secondTearsView.frame
        // 将星星有泪移动到window 上
        let rectInWindow = secondTearsView.convert(secondTearsView.bounds, to: UIApplication.shared.keyWindow)

        secondTearsView.removeFromSuperview()
        secondTearsView.frame = rectInWindow
        UIApplication.shared.keyWindow?.addSubview(secondTearsView)
        let device = UIDevice.current.orientation
        // 执行动画
        UIView.animate(withDuration: 0.35, animations: {
            if device == .landscapeRight {
                self.secondTearsView.transform = CGAffineTransform(rotationAngle: .pi / 2)
            } else {
                self.secondTearsView.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
            }
            self.secondTearsView.bounds = CGRect(x: 0, y: 0, width: (self.secondTearsView.superview?.bounds.height)!, height: (self.secondTearsView.superview?.bounds.width)!)
            self.secondTearsView.center = CGPoint(x: (self.secondTearsView.superview?.bounds.midX)!, y: (self.secondTearsView.superview?.bounds.midY)!)
        }, completion: { (isFinish) in
                self.isFullScreen = true
            })
    }

    fileprivate func exitFullScreenFunc() {
//        guard isFullScreen == true else { return }
        let rectInWindow = secondSuperView.convert(parentFrame, to: UIApplication.shared.keyWindow)

        // 执行动画
        UIView.animate(withDuration: 0.35, animations: {
            self.secondTearsView.transform = CGAffineTransform.identity
            self.secondTearsView.frame = rectInWindow
        }, completion: { (isFinish) in
                self.secondTearsView.removeFromSuperview()
                self.secondTearsView.frame = self.parentFrame
                self.secondSuperView.addSubview(self.secondTearsView)
                self.isFullScreen = false
            })
    }
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    override var prefersStatusBarHidden: Bool {
        return isFullScreen
    }
}
