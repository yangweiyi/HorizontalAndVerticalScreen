//
//  ThirdViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit

class ThirdViewController: ZRBaseController {
    lazy var centerButton: UIButton = {
        let centerBtn = UIButton(type: .custom)
        centerBtn.frame =  ZRRect(x: ScreenBounds.Width/2-50, y: ScreenBounds.Height/2-20, width: 100, hight: 40)
        centerBtn.setTitle("下一界面", for: .normal)
        centerBtn.setTitleColor(UIColor.red, for: .normal)
        centerBtn.addTarget(self, action: #selector(centerClickFunc), for: .touchUpInside)
        return centerBtn
    }()

    
    lazy var thirdTableView: UITableView = {
        let thirdView = UITableView(frame: .zero, style: .grouped)
//        thirdView.delegate = self
//        thirdView.dataSource = self
        return thirdView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.addSubview(thirdTableView)
//        thirdTableView.snp.makeConstraints { (maker) in
//            maker.left.right.top.bottom.equalToSuperview()
//        }
        NotificationCenter.default.addObserver(self, selector: #selector(openClick), name: Notification.Name("helloWorld"), object: nil)
        self.view.addSubview(centerButton)
    }
    @objc func centerClickFunc(){
         //
        let nextVC = ThirdNextViewController()

        var slideCong = ShiftInConfiguration()
        slideCong.direction = .left
        slideCong.presentationCurve = .easeOut
//        slideCong.widthForVC = WelyConstants.ContainsSize.fullScreen
//        slideCong.hightForVC = .custom(value: 200)
        
//        slideCong.directionShow = .top
//        slideCong.directionDimiss = .top
//        slideCong.verticalType = .custom(very: 100)

        slideCong.backgroudStlye = .blur(style: .dark)

//        if presentedViewControllwe .isKind(of: ChatBoardViewController.self) {
//            slideCong.isTapBackToDismissEnabled = true
//        } else {
//            slideCong.isTapBackToDismissEnabled = false
//        }

        self.welyAnimator = WelyBaseAnimator(baseCong: slideCong)
        self.welyAnimator?.prepaerFunc(currentViewController: nextVC)
        self.present(nextVC, animated: true, completion: nil)



//        let thirdNextVC = ThirdNextViewController()
//        let newModel = NewValue()
//        newModel.name = "wely"
//        newModel.title = "测试"
//        newModel.age = 29
//        thirdNextVC.newModel = newModel
//        self.navigationController?.pushViewController(thirdNextVC, animated: true)
    }
    @objc func openClick(){
        print("网络变化!!!!!:\(ZRApp.interStarte)")
    }

}

extension ThirdViewController: UITableViewDelegate {

}

//extension ThirdViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // 选中后 展示1   不选中展示0
//        return 1
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//}

class HeadView: UIView {

}
