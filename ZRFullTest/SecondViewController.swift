//
//  SecondViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit
import ReplayKit


class SecondViewController: ZRBaseController {

    lazy var startRecBtn: UIButton = {
        let startBtn = UIButton()
        startBtn.backgroundColor = .systemPink
        startBtn.setTitle("开始录屏", for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.addTarget(self, action: #selector(startClickFunc), for: .touchUpInside)
        return startBtn
    }()
    lazy var stopRecBtn: UIButton = {
        let stopBtn = UIButton()
        stopBtn.backgroundColor = .systemPink
        stopBtn.setTitle("停止录屏", for: .normal)
        stopBtn.setTitleColor(.white, for: .normal)
        stopBtn.addTarget(self, action: #selector(stopClickFunc), for: .touchUpInside)
        return stopBtn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(startRecBtn)
        view.addSubview(stopRecBtn)
        startRecBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(120)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(40)
            maker.width.equalTo(150)
        }
        stopRecBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(startRecBtn.snp.bottom).offset(40)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(40)
            maker.width.equalTo(150)
        }
        // Do any additional setup after loading the view.
    }

    @objc func startClickFunc() {
//        RPScreenRecorder.shared().startCapture(handler: { (buffler, type,error) in
//            debugPrint("视频流:\(buffler) 类型:\(type) 错误信息:\(error?.localizedDescription)")
//        }, completionHandler: { (error) in
//            debugPrint("成功后错误信息:\(error?.localizedDescription)")
//        })
    }

    @objc func stopClickFunc() {
//        RPScreenRecorder.shared().stopRecording { (preViewController, error) in
//            if error == nil{
//                preViewController?.previewControllerDelegate =  self
//                self.present(preViewController!, animated: true, completion: nil)
//            }
//        }

        RPScreenRecorder.shared().stopRecording { (preViewController, error) in


            if error == nil{
                preViewController?.previewControllerDelegate =  self
                self.present(preViewController!, animated: true, completion: nil)
            }
        }
//        RPScreenRecorder.shared().stopCapture { (error) in
//            if error == nil {
//                preViewController?.previewControllerDelegate = self
//                self.present(preViewController!, animated: true, completion: nil)
//            }
//        }
    }
}

extension SecondViewController: RPPreviewViewControllerDelegate {
    func previewController(_ previewController: RPPreviewViewController, didFinishWithActivityTypes activityTypes: Set<String>) {

    }
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {

    }
}
